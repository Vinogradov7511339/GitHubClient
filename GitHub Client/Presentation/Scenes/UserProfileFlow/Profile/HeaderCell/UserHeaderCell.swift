//
//  UserHeaderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class UserHeaderCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var userInfoStackView: UIStackView!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserHeaderCell: ConfigurableCell {
    func configure(viewModel: UserProfile) {
        avatarImageView.set(url: viewModel.user.avatarUrl)
        loginLabel.text = viewModel.user.login
        fillInfoStackView(viewModel)
    }

    func fillInfoStackView(_ profile: UserProfile) {
        userInfoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if let name = profile.name {
            addUserInfoLabel(name)
        }
        if let email = profile.userEmail {
            addUserInfoLabel(email)
        }
    }

    func addUserInfoLabel(_ text: String) {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = text
        userInfoStackView.addArrangedSubview(label)
    }
}
