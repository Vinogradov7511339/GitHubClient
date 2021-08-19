//
//  ProfileHeaderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

class ProfileHeaderCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var followButton: UIButton!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ProfileHeaderCell: ConfigurableCell {
    func configure(viewModel: UserDetails) {
        avatarImageView.set(url: viewModel.user.avatarUrl)
        nameLabel.text = viewModel.user.name
        loginLabel.text = viewModel.user.login
    }
}
