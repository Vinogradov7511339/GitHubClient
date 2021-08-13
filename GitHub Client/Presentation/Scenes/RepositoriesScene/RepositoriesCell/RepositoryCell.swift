//
//  RepositoryCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

class RepositoryCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var ownerAvatarImageView: WebImageView!
    @IBOutlet weak var ownerLoginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        ownerAvatarImageView.set(url: viewModel.owner.avatarUrl)
        ownerLoginLabel.text = viewModel.owner.login
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
    }
}
