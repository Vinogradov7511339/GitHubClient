//
//  UserActivityItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class UserActivityItemCell: BaseCollectionViewCell, NibLoadable {

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserActivityItemCell: ConfigurableCell {
    func configure(viewModel: Event) {}
}
