//
//  ResumeDetailsViewController.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

protocol ResumeDetailsDisplayLogic: class {
    func displayResume(viewModel: ResumeDetails.FetchResumeDetails.ViewModel)
    func displayError(message: String)
}

internal final class ResumeDetailsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero)
    
    var interactor: ResumeDetailsBusinessLogic?
    var router: (NSObjectProtocol & ResumeDetailsRoutingLogic & ResumeDetailsDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = ResumeDetailsInteractor()
        let presenter = ResumeDetailsPresenter()
        let router = ResumeDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func loadView() {
        super.loadView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.pinEdges([.top,.bottom,.left,.right], to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        loadData()
    }
    
    private func loadData() {
        interactor?.fetchResumeDetails()
    }
    
    private func configureTableView() {
        tableView.register(MainInfoCell.self, forCellReuseIdentifier: "MainInfoCell")
        tableView.register(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
        tableView.register(TimelineCell.self, forCellReuseIdentifier: "TimelineCell")
        tableView.separatorStyle = .none
    }
    
    private func populateTableView(with dataSource: UITableViewDataSource?, delegate: UITableViewDelegate? = nil, prefetchDataSource: UITableViewDataSourcePrefetching? = nil) {
        DispatchQueue.main.async {
            self.tableView.dataSource = dataSource
            self.tableView.delegate = delegate
            self.tableView.prefetchDataSource = prefetchDataSource
            self.tableView.reloadData()
        }
    }
}

extension ResumeDetailsViewController: ResumeDetailsDisplayLogic {
    
    func displayResume(viewModel: ResumeDetails.FetchResumeDetails.ViewModel) {
        interactor?.assign(viewModel: viewModel)
        populateTableView(with: viewModel.dataSource)
    }
    
    func displayError(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        
        present(alertVC, animated: true, completion: nil)
    }
}


