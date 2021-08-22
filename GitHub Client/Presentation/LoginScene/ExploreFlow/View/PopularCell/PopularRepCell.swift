//
//  PopularRepCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

class PopularRepCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var repNameLabel: UILabel!
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension PopularRepCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        repNameLabel.text = viewModel.name
    }
}
