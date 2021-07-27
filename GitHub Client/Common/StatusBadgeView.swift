//
//  StatusBadge.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import UIKit

enum BadgeStatus {
    case openIssue
    case closedIssue
}

class StatusBadgeView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }
    
    func completeInit() {
        setupViews()
        activateConstraints()
    }
    
    func configure(status: BadgeStatus) {
        cornerRadius = 4.0
        switch status {
        case .openIssue:
            let color = UIColor.systemGreen
            backgroundColor = color.withAlphaComponent(0.25)
            titleLabel.text = "Open"
            titleLabel.textColor = color
            imageView.image = UIImage.issue
            imageView.tintColor = color
        case .closedIssue:
            let color = UIColor.systemRed
            backgroundColor = color.withAlphaComponent(0.25)
            titleLabel.text = "Closed"
            titleLabel.textColor = color
            imageView.image = UIImage(systemName: "checkmark.circle")
            imageView.tintColor = color
        }
    }
}

// MARK: -
private extension StatusBadgeView {
    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    func activateConstraints() {
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4.0).isActive = true
        
        heightAnchor.constraint(equalToConstant: 24.0).isActive = true
    }
}
