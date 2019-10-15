//
//  Experience.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import Foundation

struct Experience: Decodable {
    let startDateString: String?
    let endDateString: String?
    let employer: String?
    let position: String?
    let info: String?
    let address: String?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()
    
     enum CodingKeys: String, CodingKey {
        case startDateString = "startDate"
        case endDateString = "endDate"
        case employer
        case info
        case position
        case address
    }
}

extension Experience {
    var startDate: Date? {
        guard let date = startDateString else { return nil }
        return dateFormatter.date(from: date)
    }
    
    var endDate: Date? {
        guard let date = endDateString else { return nil }
        return dateFormatter.date(from: date)
    }
}
