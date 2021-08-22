//
//  RepositoryInfoCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

struct RepositoryInfoCellViewModel {

    let type: RepositoryRowType
    let repository: RepositoryDetails
}

class RepositoryInfoCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryInfoCell: ConfigurableCell {
    func configure(viewModel: RepositoryInfoCellViewModel) {
        let rep = viewModel.repository
        switch viewModel.type {
        case .currentBranch:
            iconImageView.image = UIImage.Repository.branch
            titleLabel.text = "Current Branch"
            detailsLabel.text = rep.repository.currentBranch
        case .commits:
            iconImageView.image = UIImage.Repository.commits
            titleLabel.text = "Commits"
            detailsLabel.text = ""
        case .sources:
            iconImageView.image = UIImage.Repository.sources
            titleLabel.text = "Sources"
            detailsLabel.text = ""
        case .issues:
            iconImageView.image = UIImage.Repository.issues
            titleLabel.text = .issue
            detailsLabel.text = rep.repository.openIssuesCount.roundedWithAbbreviations
        case .pullRequests:
            iconImageView.image = UIImage.Repository.pullRequests
            titleLabel.text = .pullRequest
            detailsLabel.text = ""
        case .releases:
            iconImageView.image = UIImage.Repository.releases
            titleLabel.text = .releases
            detailsLabel.text = ""
        case .license:
            iconImageView.image = UIImage.Repository.license
            titleLabel.text = .license
            detailsLabel.text = ""
        case .subscribers:
            iconImageView.image = UIImage.Repository.watchers
            titleLabel.text = "Watchers"
            detailsLabel.text = rep.repository.watchersCount.roundedWithAbbreviations
        }
    }
}
