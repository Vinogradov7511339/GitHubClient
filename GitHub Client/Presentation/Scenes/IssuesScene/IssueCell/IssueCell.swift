//
//  IssueCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

class IssueCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var tempLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension IssueCell: ConfigurableCell {
    func configure(viewModel: Issue) {
        tempLabel.text = viewModel.body
    }
}
