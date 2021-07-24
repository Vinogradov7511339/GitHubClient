//
//  NotificationsEmptyView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import UIKit

class NotificationsEmptyView: UIView {
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "socialite")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.textAlignment = .center
        label.text = "All caught up!"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textAlignment = .center
        label.textColor = UIColor.secondaryLabel
        label.numberOfLines = 0
        label.text = "Take a break, write some code, and do what you do best."
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
}

private extension NotificationsEmptyView {
    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    func activateConstraints() {
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0).isActive = true
        
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
    }
}
