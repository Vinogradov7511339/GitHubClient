//
//  ResultOrganizationCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.08.2021.
//

import UIKit

class ResultOrganizationCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var tempLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ResultOrganizationCell: ConfigurableCell {
    func configure(viewModel: Organization) {
        tempLabel.text = viewModel.name
    }
}
