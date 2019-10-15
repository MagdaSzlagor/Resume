//
//  APIRequest.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public typealias HTTPHeaders = [String: String]

public typealias Parameters = [String: Any]

protocol GenericAPIRequest {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}
