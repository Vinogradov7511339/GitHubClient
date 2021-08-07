//
//  MyProfileHeaderView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import UIKit

final class MyProfileHeaderView: UIView {

    private lazy var avatarImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()

    private var imageViewHeightConstraint: NSLayoutConstraint!
    private var imageViewCenterXConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        completeInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        completeInit()
    }

    private func completeInit() {
        backgroundColor = .systemBackground
        setupViews()
        activateConstraints()
    }

    func setProfile(_ user: User) {
        avatarImageView.set(url: user.avatarUrl)
        loginLabel.text = user.login
    }

    func updateHeight(_ percent: CGFloat) {
        let newHeight = max(24.0, 64.0 * percent)
        imageViewHeightConstraint.constant = newHeight
    }
}

private extension MyProfileHeaderView {
    func setupViews() {
        addSubview(avatarImageView)
        addSubview(loginLabel)
    }

    func activateConstraints() {
        imageViewCenterXConstraint = avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        imageViewCenterXConstraint.isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        imageViewHeightConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: 64.0)
        imageViewHeightConstraint.isActive = true

        loginLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
