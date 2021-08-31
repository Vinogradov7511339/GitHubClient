//
//  RepositoryStargazersCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class RepositoryPopularityCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryPopularityCell: ConfigurableCell {
    func configure(viewModel: RepositoryInfoRowType) {
        let title: String
        let image: UIImage?
        switch viewModel {
        case .forks:
            title = NSLocalizedString("Forks", comment: "")
            image = UIImage.Repository.forks
        case .contributors:
            title = NSLocalizedString("Contributors", comment: "")
            image = UIImage.Repository.contributors
        case .stargazers:
            title = NSLocalizedString("Stargazers", comment: "")
            image = UIImage.Repository.stargazers
        case .subscribers:
            title = NSLocalizedString("Subscribers", comment: "")
            image = UIImage.Repository.subscribers
        }
        itemNameLabel.text = title
        itemImageView.image = image
    }
}
