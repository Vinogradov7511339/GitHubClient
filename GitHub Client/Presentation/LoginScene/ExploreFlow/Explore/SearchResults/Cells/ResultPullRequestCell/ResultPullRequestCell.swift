//
//  ResultPullRequestCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.08.2021.
//

import UIKit

class ResultPullRequestCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var tempLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ResultPullRequestCell: ConfigurableCell {
    func configure(viewModel: PullRequest) {
        tempLabel.text = viewModel.title
    }
}
