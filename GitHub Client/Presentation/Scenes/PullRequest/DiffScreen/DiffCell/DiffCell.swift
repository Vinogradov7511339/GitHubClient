//
//  DiffCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit
import TextCompiler

class DiffCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var hunkLabel: UILabel!
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension DiffCell: ConfigurableCell {
    func configure(viewModel: Diff) {
        fileNameLabel.text = viewModel.diffInfo
        hunkLabel.text = viewModel.hunks
    }
}
