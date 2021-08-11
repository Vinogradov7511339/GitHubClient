//
//  FavoriteRepositoryTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

struct FavoriteRepositoryCellViewModel {
    let repository: Repository
}

class FavoriteRepositoryTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var detailImageView: WebImageView!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension FavoriteRepositoryTableViewCell: ConfigurableCell {
    func configure(viewModel: FavoriteRepositoryCellViewModel) {
        let isFavorite = AppDIContainer.shared.favoritesStorage.contains(viewModel.repository.repositoryId)
        let imageName = isFavorite ? "xmark.circle.fill" : "plus.circle"
        detailImageView.image = UIImage(systemName: imageName)
        avatarImageView.set(url: viewModel.repository.owner.avatarUrl)
        ownerNameLabel.text = viewModel.repository.owner.login
        repositoryNameLabel.text = viewModel.repository.name
    }
}
