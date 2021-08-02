//
//  SmallCollectionViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct SmallCellViewModel {
    
    let repositoryImageUrl: URL?
    let repositoryName: String
    let isStarred: Bool
    let starCount: String
    let language: String
    
    init(repository: RepositoryResponse) {
        repositoryImageUrl = repository.owner?.avatarUrl
        repositoryName = repository.fullName ?? ""
        isStarred = false
        starCount = "\(repository.stargazersCount ?? 0)"
        language = repository.language ?? ""
    }
}

class SmallCollectionViewCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var repositoryImageView: WebImageView!
    @IBOutlet weak var repositoryName: UILabel!
//    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var starCountLabel: UILabel!
//    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension SmallCollectionViewCell: ConfigurableCell {
    func configure(viewModel: SmallCellViewModel) {
        repositoryImageView.set(url: viewModel.repositoryImageUrl)
        repositoryName.text = viewModel.repositoryName
        starCountLabel.text = viewModel.starCount
        languageLabel.text = viewModel.language
    }
}
