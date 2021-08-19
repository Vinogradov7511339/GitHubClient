//
//  RepositoryInfoCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

struct RepositoryInfoCellViewModel {
    enum CellType: Int {
        case sources
        case issues
        case pullRequests
        case releases
        case license
        case subscribers
    }

    let type: CellType
    let repository: Repository
}

class RepositoryInfoCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryInfoCell: ConfigurableCell {
    func configure(viewModel: RepositoryInfoCellViewModel) {
        switch viewModel.type {
        case .sources:
            iconImageView.image = .sources
            iconImageView.tintColor = .issue
            titleLabel.text = "Sources"
        case .issues:
            iconImageView.image = .issue
            iconImageView.tintColor = .issue
            titleLabel.text = .issue
        case .pullRequests:
            iconImageView.image = .pullRequest
            iconImageView.tintColor = .pullRequest
            titleLabel.text = .pullRequest
        case .releases:
            iconImageView.image = .releases
            iconImageView.tintColor = .releases
            titleLabel.text = .releases
        case .license:
            iconImageView.image = .license
            iconImageView.tintColor = .license
            titleLabel.text = .license
        case .subscribers:
            iconImageView.image = .releases
            iconImageView.tintColor = .releases
            titleLabel.text = "Subscribers"
        }
    }
}
