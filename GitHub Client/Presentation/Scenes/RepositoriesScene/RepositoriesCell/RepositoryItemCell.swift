//
//  RepositoryItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.08.2021.
//

import UIKit

class RepositoryItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: WebImageView!
    @IBOutlet weak var ownerLoginLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension RepositoryItemCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        repositoryNameLabel.text = viewModel.name
        ownerAvatarImageView.set(url: viewModel.owner.avatarUrl)
        ownerLoginLabel.text = viewModel.owner.login
        repositoryDescriptionLabel.text = viewModel.description
        starsCountLabel.text = "\(viewModel.starsCount)"
    }
}
