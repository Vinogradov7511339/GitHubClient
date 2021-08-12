//
//  UserCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

class UserCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserCell: ConfigurableCell {
    func configure(viewModel: User) {
        avatarImageView.set(url: viewModel.avatarUrl)
        loginLabel.text = viewModel.login
    }
}
