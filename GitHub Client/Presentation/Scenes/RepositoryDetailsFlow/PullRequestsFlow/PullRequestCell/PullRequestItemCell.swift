//
//  PullRequestItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

class PullRequestItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var tempLabel: UILabel!
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension PullRequestItemCell: ConfigurableCell {
    func configure(viewModel: PullRequest) {
        tempLabel.text = viewModel.title
    }
}
