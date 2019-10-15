//
//  TimelineCell.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

struct TimelineDTO: CellDTO {
    let identifier = "TimelineCell"
    let data: Any?
}

struct TimelineDTOInput {
    let viewModel: TimelineCell.ViewModel
}

internal class TimelineCell: UITableViewCell, CellConfigurable {
    
    private let titleLabel = UILabel(frame: .zero)
    private let dateLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let infoLabel = UILabel(frame: .zero)
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
    
    struct ViewModel {
        let startDate: Date?
        let endDate: Date?
        let title: String?
        let subtitle: String?
        let info: String?
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
        addSubviews()
    }
    
    func configure(data: Any?) {
        guard let data = data as? TimelineDTOInput else { return }
        let viewModel = data.viewModel
        
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        infoLabel.text = viewModel.info
        
        if let startDate = viewModel.startDate {
            var text = dateFormatter.string(from: startDate)
            
            if let endDate = viewModel.endDate {
                text += "\n\(dateFormatter.string(from: endDate))"
            } else {
                text += "\nnow"
            }
            dateLabel.text = text
        }
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        titleLabel.font = ResumeFont.helveticaNeue.bold(size: 19)
        subtitleLabel.font = ResumeFont.helveticaNeue.italic(size: 16)
        dateLabel.font = ResumeFont.helveticaNeue.bold(size: 19)
        infoLabel.font = ResumeFont.helveticaNeue.regular(size: 16)
        
        titleLabel.textColor = UIColor.black
        subtitleLabel.textColor = UIColor.black
        dateLabel.textColor = UIColor.black
        infoLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        infoLabel.numberOfLines = 0
        dateLabel.numberOfLines = 0
        
        dateLabel.textAlignment = .right
    }
    
    private func addSubviews() {
        let width = UIScreen.main.bounds.size.width * 0.2
        dateLabel.addWidthConstraint(with: width)
        
        let stackView = UIStackView()
        contentView.addSubview(stackView)
        
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        
        let dataStackView = UIStackView()
        dataStackView.axis = .vertical
        dataStackView.spacing = 8
        
        dataStackView.addArrangedSubview(titleLabel)
        dataStackView.addArrangedSubview(subtitleLabel)
        dataStackView.addArrangedSubview(infoLabel)
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(dataStackView)
        
        stackView.pinLeft(to: contentView, constant: 24)
        stackView.pinRight(to: contentView, constant: -24)
        stackView.pinBottom(to: contentView, constant: -10)
        stackView.pinTop(to: contentView, constant: 10)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        subtitleLabel.text = nil
        dateLabel.text = nil
        infoLabel.text = nil
        
        super.prepareForReuse()
    }
}
