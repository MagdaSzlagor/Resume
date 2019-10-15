//
//  ResumeDetailsPresenter.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import Foundation

protocol ResumeDetailsPresentationLogic: class {
    func presentResumeDetails(_ resume: Resume)
    func presentError(message: String)
}

class ResumeDetailsPresenter: ResumeDetailsPresentationLogic {
    
    weak var viewController: ResumeDetailsDisplayLogic?
    
    func presentError(message: String) {
        viewController?.displayError(message: message)
    }
    
    func presentResumeDetails(_ resume: Resume) {
        let dataSource = ResumeDetailsTableViewDatasource(with: resume)
        let viewModel = ResumeDetails.FetchResumeDetails.ViewModel(dataSource: dataSource)
        viewController?.displayResume(viewModel: viewModel)
    }
}
