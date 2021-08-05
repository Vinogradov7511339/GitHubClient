//
//  FavoriteRepositoryTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

struct FavoriteRepositoryCellViewModel {
    let image: UIImage?
    let repository: RepositoryResponse
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
        avatarImageView.set(url: viewModel.repository.owner?.avatarUrl)
        ownerNameLabel.text = viewModel.repository.owner?.login ?? ""
        repositoryNameLabel.text = viewModel.repository.name ?? ""
        detailImageView.image = viewModel.image
    }
}
