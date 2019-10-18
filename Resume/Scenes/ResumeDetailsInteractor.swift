//
//  ResumeDetailsInteractor.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

protocol ResumeDetailsBusinessLogic {
    func fetchResumeDetails()
    func assign(viewModel: ResumeDetails.FetchResumeDetails.ViewModel)
}

protocol ResumeDetailsDataStore {
    var cvTableViewDataSource: UITableViewDataSource? { get set }
    var resume: Resume? { get set }
}

class ResumeDetailsInteractor: ResumeDetailsBusinessLogic, ResumeDetailsDataStore {
  
    var resume: Resume?
    var cvTableViewDataSource: UITableViewDataSource?
    var presenter: ResumeDetailsPresentationLogic?
    var worker: ResumeDetailsWorker = ResumeDetailsWorker()
    
    func fetchResumeDetails() {
        worker.fetchResumeDetails(onSuccess: { [weak self] (resume) in
            self?.fetchResumeDetailsDidSucceed(with: resume)
        }) { [weak self] (error) in
            self?.fetchResumeDetailsDidFailed(with: error)
        }
    }
    
    func assign(viewModel: ResumeDetails.FetchResumeDetails.ViewModel) {
        cvTableViewDataSource = viewModel.dataSource
    }
    
    private func fetchResumeDetailsDidSucceed(with resume: Resume) {
        self.resume = resume
        presenter?.presentResumeDetails(resume)
    }
    
    private func fetchResumeDetailsDidFailed(with error: NetworkingError) {
        self.resume = nil
        presenter?.presentError(message: error.localizedDescription)
    }
}

