//
//  ResumeDetailsRouter.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

protocol ResumeDetailsRoutingLogic {
    
}

protocol ResumeDetailsDataPassing {
    var dataStore: ResumeDetailsDataStore? { get }
}

class ResumeDetailsRouter: NSObject, ResumeDetailsRoutingLogic, ResumeDetailsDataPassing {
   
    var dataStore: ResumeDetailsDataStore?
    weak var viewController: ResumeDetailsViewController?
}
