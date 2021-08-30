//
//  RepositoryForksCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class RepositoryForksCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var forksCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryForksCell: ConfigurableCell {
    func configure(viewModel: RepositoryDetails) {
        forksCountLabel.text = viewModel.repository.forksCount.separatedBy(".")
    }
}
