//
//  Resume.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import Foundation

struct Resume: Decodable {
    
    let email: String?
    let name: String?
    let surname: String?
    let phoneNumber: String?
    let profileImage: String?
    let summary: String?
    let experience: [Experience]?
    let education: [Education]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case surname
        case email
        case phoneNumber = "phone"
        case profileImage = "image"
        case experience
        case education
        case summary
    }
}
