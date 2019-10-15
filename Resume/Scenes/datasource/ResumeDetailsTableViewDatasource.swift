//
//  ResumeDetailsTableViewDatasource.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

struct ResumeSection {
    let cellIdentifier: String
    let items: [Any]
}

class ResumeDetailsTableViewDatasource: NSObject, UITableViewDataSource {
    
    private var resume: Resume?
    private var cellDTOs: [CellDTO] = []
    
    init(with resume: Resume) {
        self.resume = resume
        super.init()
        setupDataSource()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDTOs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDTO = cellDTOs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDTO.identifier)!
        if let cell = cell as? CellConfigurable {
            cell.configure(data: cellDTO.data)
        }
       
        return cell
    }
}

extension ResumeDetailsTableViewDatasource {
    private func setupDataSource() {
        let mainInfoViewModel = MainInfoCell.ViewModel(name: resume?.name, surname: resume?.surname, imageUrl: resume?.profileImage, summary: resume?.summary, email: resume?.email, phone: resume?.phoneNumber)
        let mainCell = MainInfoDTO(data: MainInfoDTOInput(viewModel: mainInfoViewModel))
        cellDTOs.append(mainCell)
        
        if let education = resume?.education, education.count > 0 {
            let viewModel = HeaderCell.ViewModel(title: "Education")
            let headerCell = HeaderDTO(data: HeaderDTOInput(viewModel: viewModel))
            cellDTOs.append(headerCell)
            
            education.forEach { (obj) in
                let viewModel = TimelineCell.ViewModel.init(startDate: obj.startDate, endDate: obj.endDate, title: obj.university, subtitle: obj.title, info: obj.info)
                let cell = TimelineDTO(data: TimelineDTOInput(viewModel: viewModel))
                cellDTOs.append(cell)
            }
        }
        
        if let experience = resume?.experience, experience.count > 0 {
            let viewModel = HeaderCell.ViewModel(title: "Experience")
            let headerCell = HeaderDTO(data:HeaderDTOInput(viewModel: viewModel))
            cellDTOs.append(headerCell)
            
            experience.forEach { (obj) in
                let viewModel = TimelineCell.ViewModel.init(startDate: obj.startDate, endDate: obj.endDate, title: obj.employer, subtitle: obj.position, info: obj.info)
                let cell = TimelineDTO(data: TimelineDTOInput(viewModel: viewModel))
                cellDTOs.append(cell)
            }
        }
    }
}
