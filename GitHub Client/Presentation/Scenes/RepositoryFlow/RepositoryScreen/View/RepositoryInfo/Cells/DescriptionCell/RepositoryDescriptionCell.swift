//
//  RepositoryDescriptionCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class RepositoryDescriptionCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var descriptionLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension RepositoryDescriptionCell: ConfigurableCell {
    func configure(viewModel: RepositoryDetails) {
        descriptionLabel.text = viewModel.repository.description
    }
}
