//
//  Education.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import Foundation

struct Education: Decodable {
    let startDateString: String?
    let endDateString: String?
    let university: String?
    let info: String?
    let title: String?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    enum CodingKeys: String, CodingKey {
        case startDateString = "startDate"
        case endDateString = "endDate"
        case university
        case info
        case title
    }
}

extension Education {
    var startDate: Date? {
        guard let date = startDateString else { return nil }
        return dateFormatter.date(from: date)
    }
    
    var endDate: Date? {
        guard let date = endDateString else { return nil }
        return dateFormatter.date(from: date)
    }
}
