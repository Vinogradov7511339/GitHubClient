//
//  RepositoryStargazersCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class RepositoryStargazersCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var stargazersCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryStargazersCell: ConfigurableCell {
    func configure(viewModel: RepositoryDetails) {
        stargazersCountLabel.text = viewModel.repository.watchersCount.roundedWithAbbreviations
    }
}
