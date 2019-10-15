//
//  ResumeDetailsModels.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

enum ResumeDetails {
    
    enum FetchResumeDetails {
        
        struct APIRequest: GenericAPIRequest {
            var method: HTTPMethod = .get
            var path: String = "/bins/rsxt2"
            var parameters: Parameters?
            var headers: HTTPHeaders? {
                get {
                    return ["application/json" : "Accept"]
                }
            }
        }
        
        struct Response {
            let dataSource: UITableViewDataSource?
            let errorMessage: String?
        }
        
        struct ViewModel {
            let dataSource: UITableViewDataSource
        }
    }
}
