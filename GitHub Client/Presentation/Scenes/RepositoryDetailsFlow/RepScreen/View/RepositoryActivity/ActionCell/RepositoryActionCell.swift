//
//  RepositoryActionCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class RepositoryActionCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryActionCell: ConfigurableCell {
    func configure(viewModel: RepositoryActionsRowType) {
        let title: String
        let image: UIImage?
        switch viewModel {
        case .sources:
            title = NSLocalizedString("Sources", comment: "")
            image = UIImage.Repository.sources
        case .commits:
            title = NSLocalizedString("Commits", comment: "")
            image = UIImage.Repository.commits
        case .branches:
            title = NSLocalizedString("Branches", comment: "")
            image = UIImage.Repository.branch
        case .issues:
            title = NSLocalizedString("Issues", comment: "")
            image = UIImage.Repository.issues
        case .pullRequests:
            title = NSLocalizedString("Pull Requests", comment: "")
            image = UIImage.Repository.pullRequests
        case .releases:
            title = NSLocalizedString("Releases", comment: "")
            image = UIImage.Repository.releases
        }
        itemTitleLabel.text = title
        itemImageView.image = image
    }
}
