//
//  AccountCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

class AccountCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension AccountCell: ConfigurableCell {
    func configure(viewModel: User) {
        avatarImageView.set(url: viewModel.avatarUrl)
        loginLabel.text = viewModel.login
    }
}
