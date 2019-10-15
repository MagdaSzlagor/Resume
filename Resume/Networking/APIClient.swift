//
//  APIClient.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(NetworkingError)
}

struct Request<T> {
    let apiRequest: GenericAPIRequest
    let parseResponse: (Data?) -> Result<T>
    
    init (apiRequest: GenericAPIRequest, parseResponse: @escaping (Data?) -> Result<T>) {
        self.apiRequest = apiRequest
        self.parseResponse = parseResponse
    }
}

final class APIClient: NSObject {
    
    static let shared: APIClient = APIClient()
    
    private let apiURL = "https://api.myjson.com"
    private override init() { }
    
    func call<T: Decodable>(request: Request<T>, completion: @escaping (Result<T>) -> ()) {
       
        guard Reachability.isConnectedToNetwork() else {
            completion(.failure(.noInternetConnection))
            return
        }
        
        let endpoint = apiURL + request.apiRequest.path
        guard let url = URL(string: endpoint) else {
            fatalError("invalid url")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.apiRequest.method.rawValue
        request.apiRequest.headers?.forEach({ (header) in
            let (key, value) = header
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        
        if let params = request.apiRequest.parameters, let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) {
            urlRequest.httpBody = data
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else { completion(.failure(.returnedError(error!))); return }
            guard let response = response as? HTTPURLResponse else { completion(.failure(.customError("invalid response"))); return }
            guard 200..<300 ~= response.statusCode else { completion(.failure(.invalidStatusCode(response.statusCode))); return }
            guard let data = data else { completion(.failure(.dataReturnedNil)); return}
            
            completion(request.parseResponse(data))
        }.resume()
    }
}

enum NetworkingError: Error, Equatable {
    
    static public func ==(lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs,rhs) {
        case (.errorParsingJSON,.errorParsingJSON):
            return true
        case (.noInternetConnection,.noInternetConnection):
            return true
        case (.dataReturnedNil,.dataReturnedNil):
            return true
        case (.expiredTokenError,.expiredTokenError):
            return true
        case (.returnedError(let errorA),.returnedError(let errorB)):
            return errorA.localizedDescription == errorB.localizedDescription
        case (.invalidStatusCode(let statusA),.invalidStatusCode(let statusB)):
            return statusA == statusB
        case (.customError(let errorA),.customError(let errorB)):
            return errorA == errorB
        default:
            return false
        }
    }
    
    case errorParsingJSON
    case noInternetConnection
    case dataReturnedNil
    case returnedError(Error)
    case invalidStatusCode(Int)
    case customError(String)
    case expiredTokenError
    
    var localizedDescription: String {
        get {
            switch self {
            case .errorParsingJSON:
                return NSLocalizedString("parsingJSONError", comment: "")
            case .noInternetConnection:
                return NSLocalizedString("noInternetConnectionError", comment: "")
            case .dataReturnedNil:
                return NSLocalizedString("nilDataError", comment: "")
            case .returnedError(let error):
                return error.localizedDescription
            case .invalidStatusCode(let code):
                return "\(NSLocalizedString("webserviceError", comment: "")) \(code)"
            case .customError(let error):
                return error
            case .expiredTokenError:
                return NSLocalizedString("expiredTokenError", comment: "")
            }
        }
    }
}
