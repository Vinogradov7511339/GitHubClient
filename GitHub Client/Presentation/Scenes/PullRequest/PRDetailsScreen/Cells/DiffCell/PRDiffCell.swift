//
//  PRDiffCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

class PRDiffCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var filesChangedCountLabel: UILabel!
    @IBOutlet weak var addedRowsCountLabel: UILabel!
    @IBOutlet weak var deletedRowsCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension PRDiffCell: ConfigurableCell {
    func configure(viewModel: PullRequestDetails) {
        filesChangedCountLabel.text = "\(viewModel.changedFilesCount) files changed"
        addedRowsCountLabel.text = "+\(viewModel.additionsCount.separatedBy(","))"
        deletedRowsCountLabel.text = "-\(viewModel.deletionsCount.separatedBy(","))"
    }
}
