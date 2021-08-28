//
//  PRCommitsCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

class PRCommitsCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var commitsCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension PRCommitsCell: ConfigurableCell {
    func configure(viewModel: PullRequestDetails) {
        commitsCountLabel.text = "\(viewModel.commitsCount) commits"
    }
}
