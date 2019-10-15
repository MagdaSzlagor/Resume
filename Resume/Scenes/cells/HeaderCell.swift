//
//  HeaderCell.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

struct HeaderDTO: CellDTO {
    let identifier = "HeaderCell"
    let data: Any?
}

struct HeaderDTOInput {
    let viewModel: HeaderCell.ViewModel
    //    let onPress: (()->())?
}

internal class HeaderCell: UITableViewCell, CellConfigurable {
    
    private let titleLabel = UILabel(frame: .zero)
    
    struct ViewModel {
        let title: String?
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    func configure(data: Any?) {
        guard let data = data as? HeaderDTOInput else { return }
        let viewModel = data.viewModel
        titleLabel.text = viewModel.title
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        titleLabel.font = ResumeFont.helveticaNeue.bold(size: 19)
        titleLabel.textColor = UIColor.darkBlue
        
        contentView.addSubview(titleLabel)
        
        titleLabel.pinEdges([.left,.right], to: contentView, constant: 24)
        titleLabel.pinTop(to: contentView, constant: 5)
        titleLabel.pinBottom(to: contentView, constant: -5)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        
        super.prepareForReuse()
    }
}

