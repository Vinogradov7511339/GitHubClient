//
//  CommitCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

class CommitCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var tempLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CommitCell: ConfigurableCell {
    func configure(viewModel: Commit) {
        tempLabel.text = viewModel.message
    }
}
