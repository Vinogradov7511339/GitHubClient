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
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var openIssuesCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}

// MARK: - ConfigurableCell
extension RepositoryCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        ownerAvatarImageView.set(url: viewModel.owner.avatarUrl)
        ownerLoginLabel.text = viewModel.owner.login
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        languageLabel.text = viewModel.language
        starsCountLabel.text = "\(viewModel.starsCount)"
        forksCountLabel.text = "\(viewModel.forksCount)"
        openIssuesCountLabel.text = "\(viewModel.openIssuesCount)"
    }
}
