//
//  ResultIssueCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

class ResultIssueCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var tempLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ResultIssueCell: ConfigurableCell {
    func configure(viewModel: Issue) {
        tempLabel.text = viewModel.title
    }
}
