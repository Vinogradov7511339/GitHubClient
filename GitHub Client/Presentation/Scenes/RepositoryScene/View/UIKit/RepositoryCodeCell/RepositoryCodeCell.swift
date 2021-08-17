//
//  RepositoryCodeCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

struct RepositoryCodeCellViewModel {
    enum CellType: Int {
        case code
        case commits
    }

    let type: CellType
}

class RepositoryCodeCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var titleLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryCodeCell: ConfigurableCell {
    func configure(viewModel: RepositoryCodeCellViewModel) {
        switch viewModel.type {
        case .code:
            titleLabel.text = NSLocalizedString("Browse code", comment: "")
        case .commits:
            titleLabel.text = NSLocalizedString("Commits", comment: "")
        }
    }
}
