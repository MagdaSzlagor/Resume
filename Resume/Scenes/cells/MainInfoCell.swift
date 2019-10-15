//
//  MainInfoCell.swift
//  Resume
//
//  Created by Magdalena Szlagor on 14/10/2019.
//  Copyright © 2019 Magdalena Szlagor. All rights reserved.
//

import UIKit

protocol CellConfigurable {
    func configure(data: Any?)
}

protocol CellDTO {
    var identifier: String { get }
    var data: Any? { get }
}

struct MainInfoDTO: CellDTO {
    let identifier = "MainInfoCell"
    let data: Any?
}

struct MainInfoDTOInput {
    let viewModel: MainInfoCell.ViewModel
}

internal class MainInfoCell: UITableViewCell, CellConfigurable {
    
    struct ViewModel {
        let name: String?
        let surname: String?
        let imageUrl: String?
        let summary: String?
        let email: String?
        let phone: String?
    }
    
    private let nameLabel = UILabel(frame: .zero)
    private let surnameLabel = UILabel(frame: .zero)
    private let emailLabel = UILabel(frame: .zero)
    private let phoneLabel = UILabel(frame: .zero)
    private let summaryLabel = UILabel(frame: .zero)
    private let summaryTitleLabel = UILabel(frame: .zero)
    private let avatarImageView = UIImageView(frame: .zero)
    
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
        guard let data = data as? MainInfoDTOInput else { return }
        let viewModel = data.viewModel
        nameLabel.text = viewModel.name
        surnameLabel.text = viewModel.surname
        summaryLabel.text = viewModel.summary
        emailLabel.text = viewModel.email
        phoneLabel.text = viewModel.phone
        if let urlString = viewModel.imageUrl, let url = URL(string: urlString) {
            avatarImageView.load(url: url)
        }
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        nameLabel.font = ResumeFont.helveticaNeue.regular(size: 22)
        surnameLabel.font = ResumeFont.helveticaNeue.bold(size: 24)
        emailLabel.font = ResumeFont.helveticaNeue.regular(size: 18)
        phoneLabel.font = ResumeFont.helveticaNeue.regular(size: 18)
        summaryTitleLabel.font = ResumeFont.helveticaNeue.bold(size: 19)
        summaryLabel.font = ResumeFont.helveticaNeue.regular(size: 16)
        
        nameLabel.textColor = UIColor.darkBlue
        surnameLabel.textColor = UIColor.darkBlue
        emailLabel.textColor = UIColor.black
        phoneLabel.textColor = UIColor.black
        summaryTitleLabel.textColor = UIColor.darkBlue
        summaryLabel.textColor = UIColor.black
        
        nameLabel.numberOfLines = 0
        surnameLabel.numberOfLines = 0
        emailLabel.numberOfLines = 0
        phoneLabel.numberOfLines = 0
        summaryLabel.numberOfLines = 0
        
        avatarImageView.addHeightConstraint(with: 44)
        avatarImageView.addWidthConstraint(with: 44)
        avatarImageView.layer.cornerRadius = 22
        avatarImageView.layer.masksToBounds = true
        
        summaryTitleLabel.text = "Summary"
        
        emailLabel.addTapGestureRecognizer {
            self.mail(self.emailLabel.text ?? "")
        }
        
        phoneLabel.addTapGestureRecognizer {
            self.call(self.phoneLabel.text ?? "")
        }
    }
    
    private func addSubviews() {
        let stackView = UIStackView()
        contentView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 8.0
        
        let summaryStackView = UIStackView()
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 5.0
        summaryStackView.addArrangedSubview(summaryTitleLabel)
        summaryStackView.addArrangedSubview(summaryLabel)
        
        let nameStackView = UIStackView()
        nameStackView.axis = .vertical
        nameStackView.spacing = 8
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(surnameLabel)
        
        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.spacing = 12
        topStackView.alignment = .center
        topStackView.addArrangedSubview(nameStackView)
        topStackView.addArrangedSubview(avatarImageView)
        
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(summaryStackView)
        
        stackView.customSpacing(after: emailLabel)
        
        stackView.pinEdges([.left,.top], to: contentView, constant: 24)
        stackView.pinEdges([.bottom,.right], to: contentView, constant: -24)
    }
    
    private func call(_ phoneNr: String) {
        if let url = URL(string: "tel://\(phoneNr)") {
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func mail(_ emailAddress: String) {
        if let url = URL(string: "mailto:\(emailAddress)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        summaryLabel.text = nil
        emailLabel.text = nil
        phoneLabel.text = nil
        summaryLabel.text = nil
        avatarImageView.image = nil
        
        super.prepareForReuse()
    }
}
