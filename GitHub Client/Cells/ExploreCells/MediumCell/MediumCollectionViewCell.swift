//
//  MediumCollectionViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct MediumCellViewModel {
    
    let repositoryImageUrl: URL?
    let ownerName: String
    let repositoryName: String
    let isStarred: Bool
    let starCount: String
    let language: String
    let languageColor: UIColor?
    
    init(repository: Repository) {
        repositoryImageUrl = repository.owner?.avatar_url
        ownerName = repository.owner?.login ?? ""
        repositoryName = repository.name ?? ""
        isStarred = false
        starCount = "\(repository.stargazers_count ?? 0)"
        language = repository.language ?? ""
        languageColor = UIColor.getLanguageColor(for: repository.language)
    }
}

class MediumCollectionViewCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var repositoryAvatarImageView: WebImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var languageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension MediumCollectionViewCell: ConfigurableCell {
    func configure(viewModel: MediumCellViewModel) {
        repositoryAvatarImageView.set(url: viewModel.repositoryImageUrl)
        ownerNameLabel.text = viewModel.ownerName
        repositoryNameLabel.text = viewModel.repositoryName
        starsCountLabel.text = viewModel.starCount
        languageLabel.text = viewModel.language
//        if let languageColor = viewModel.languageColor {
//            languageImageView.tintColor = languageColor
//        }
    }
}
