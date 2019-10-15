//
//  ResumeDetailsWorker.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import Foundation

class ResumeDetailsWorker {
    
    func fetchResumeDetails(onSuccess: @escaping ((Resume) -> Void), onError: @escaping ((NetworkingError) -> Void)) {
        
        let request = Request<Resume>(apiRequest: ResumeDetails.FetchResumeDetails.APIRequest()) { jsonData in
            if let jsonData = jsonData {
                do {
                    let response = try JSONDecoder().decode(Resume.self, from: jsonData)
                    return .success(response)
                } catch {
                    return .failure(.errorParsingJSON)
                }
            }
            else {
                return .failure(.dataReturnedNil)
            }
        }
        
        APIClient.shared.call(request: request) { (result) in
            switch result {
            case .success(let response):
                onSuccess(response)
                break
            case .failure(let error):
                onError(error)
                break
            }
        }
    }
}
