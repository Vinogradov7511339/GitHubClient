//
//  RepositoryOwnerCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class RepositoryOwnerCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var ownerAvatarImageView: WebImageView!
    @IBOutlet weak var ownerLoginLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryOwnerCell: ConfigurableCell {
    func configure(viewModel: RepositoryDetails) {
        ownerAvatarImageView.set(url: viewModel.repository.owner.avatarUrl)
        ownerLoginLabel.text = viewModel.repository.owner.login
    }
}
