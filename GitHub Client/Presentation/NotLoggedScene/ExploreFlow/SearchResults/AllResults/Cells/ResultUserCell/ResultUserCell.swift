//
//  ResultUserCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

class ResultUserCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var userLoginLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ResultUserCell: ConfigurableCell {
    func configure(viewModel: User) {
        userAvatarImageView.set(url: viewModel.avatarUrl)
        userLoginLabel.text = viewModel.login
    }
}
