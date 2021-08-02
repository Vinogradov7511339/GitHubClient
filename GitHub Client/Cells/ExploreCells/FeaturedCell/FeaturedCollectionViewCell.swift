//
//  FeaturedCollectionViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct FeaturedCellViewModel {
    
    let repositoryImageUrl: URL?
    let type: String
    let repositoryName: String
    let repositoryDescription: String
    let isStarred: Bool
    let starsCount: String
    let language: String
    let languageColor: UIColor?
    
    init(repository: RepositoryResponse) {
        repositoryImageUrl = nil
        type = "FEATURED REPOSITORY"
        repositoryName = repository.name ?? ""
        repositoryDescription = repository.description ?? ""
        isStarred = false
        starsCount = "\(repository.stargazersCount ?? 0)"
        language = repository.language ?? ""
        languageColor = UIColor.getLanguageColor(for: repository.language)
    }
}

class FeaturedCollectionViewCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: WebImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension FeaturedCollectionViewCell: ConfigurableCell {
    func configure(viewModel: FeaturedCellViewModel) {
//        imageView.set(url: viewModel.repositoryImageUrl)
        typeLabel.text = viewModel.type
        nameLabel.text = viewModel.repositoryName
        detailLabel.text = viewModel.repositoryDescription
        starImageView.tintColor = viewModel.isStarred ? .systemYellow : .systemGray
        
        if let languageColor = viewModel.languageColor {
            languageImageView.tintColor = languageColor
        }
        
        starsCountLabel.text = viewModel.starsCount
        languageLabel.text = viewModel.language
    }
}
