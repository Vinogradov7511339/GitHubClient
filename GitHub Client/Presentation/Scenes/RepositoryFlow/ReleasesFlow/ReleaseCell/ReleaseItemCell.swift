//
//  ReleaseItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

class ReleaseItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var tempLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ReleaseItemCell: ConfigurableCell {
    func configure(viewModel: Release) {
        tempLabel.text = viewModel.name
    }
}
