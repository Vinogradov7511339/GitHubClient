//
//  BranchCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.08.2021.
//

import UIKit

class BranchCell: BaseTableViewCell, NibLoadable {
    @IBOutlet weak var branchNameLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension BranchCell: ConfigurableCell {
    func configure(viewModel: Branch) {
        branchNameLabel.text = viewModel.name
    }
}
