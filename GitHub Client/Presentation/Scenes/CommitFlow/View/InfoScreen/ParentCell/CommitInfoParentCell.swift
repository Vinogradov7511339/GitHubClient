//
//  CommitInfoParentCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

class CommitInfoParentCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var shaLabel: UILabel!
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CommitInfoParentCell: ConfigurableCell {
    func configure(viewModel: Commit) {
        if let sha = viewModel.parents.first?.sha.prefix(7) {
            shaLabel.text = String(sha)
        }
    }
}
