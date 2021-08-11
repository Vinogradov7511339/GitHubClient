//
//  StarredRepoTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import UIKit

class StarredRepoTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var ownerLoginLabel: UILabel!
    @IBOutlet weak var reposNameLabel: UILabel!
    @IBOutlet weak var reposDescriptionLabel: UILabel!
    @IBOutlet weak var isStarredImageView: UIImageView!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var languageColorImageView: WebImageView!
    @IBOutlet weak var languageLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension StarredRepoTableViewCell: ConfigurableCell {
    func configure(viewModel: Any) {
        if let old = viewModel as? RepositoryResponseDTO {
            configure(old: old)
        } else if let new = viewModel as? Repository {
            configure(new: new)
        }
    }
    
    func configure(old viewModel: RepositoryResponseDTO) {
        avatarImageView.set(url: viewModel.owner?.avatarUrl)
        ownerLoginLabel.text = viewModel.owner?.login ?? ""
        reposNameLabel.text = viewModel.name ?? ""
        if let description = viewModel.description {
            reposDescriptionLabel.isHidden = false
            reposDescriptionLabel.text = description
        } else {
            reposDescriptionLabel.isHidden = true
        }
//        isStarredImageView todo
        starsCountLabel.text = "\(viewModel.stargazersCount ?? 0)"
        if let language = viewModel.language {
            languageColorImageView.isHidden = false
            languageLabel.isHidden = false
            languageColorImageView.tintColor = UIColor.getLanguageColor(for: language)
            languageLabel.text = language
        } else {
            languageColorImageView.isHidden = true
            languageLabel.isHidden = true
        }
    }
    
    func configure(new viewModel: Repository) {
        avatarImageView.set(url: viewModel.owner.avatarUrl)
        ownerLoginLabel.text = viewModel.owner.login
        reposNameLabel.text = viewModel.name
        if let description = viewModel.description {
            reposDescriptionLabel.isHidden = false
            reposDescriptionLabel.text = description
        } else {
            reposDescriptionLabel.isHidden = true
        }
//        isStarredImageView todo
        starsCountLabel.text = "\(viewModel.starsCount)"
        if let language = viewModel.language {
            languageColorImageView.isHidden = false
            languageLabel.isHidden = false
            languageColorImageView.tintColor = UIColor.getLanguageColor(for: language)
            languageLabel.text = language
        } else {
            languageColorImageView.isHidden = true
            languageLabel.isHidden = true
        }
    }
}
