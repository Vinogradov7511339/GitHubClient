//
//  CommitInfoMessageCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

class CommitInfoMessageCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var bodyLabel: UILabel!
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CommitInfoMessageCell: ConfigurableCell {
    func configure(viewModel: Commit) {
        bodyLabel.text = viewModel.message
    }
}
