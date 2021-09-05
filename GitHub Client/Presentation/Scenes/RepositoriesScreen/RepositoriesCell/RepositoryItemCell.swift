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
    @IBOutlet weak var ownerLoginButton: UIButton!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forksView: UIView!
    @IBOutlet weak var forksCount: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension RepositoryItemCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        repositoryNameLabel.text = viewModel.name
        ownerAvatarImageView.set(url: viewModel.owner.avatarUrl)
        ownerLoginButton.setTitle(viewModel.owner.login, for: .normal)
        repositoryDescriptionLabel.text = viewModel.description

        languageView.isHidden = viewModel.language == nil
        if let language = viewModel.language {
            languageView.isHidden = false
//            languageImageView.tintColor
            languageLabel.text = language
        }

        starsCountLabel.text = viewModel.starsCount.roundedWithAbbreviations
        let starsColor: UIColor = viewModel.starsCount == 0 ? .secondaryLabel : .systemYellow
        starsImageView.tintColor = starsColor

        forksView.isHidden = viewModel.forksCount == 0
        forksCount.text = viewModel.forksCount.roundedWithAbbreviations
    }
}
