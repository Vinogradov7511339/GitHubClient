//
//  ProfileItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

struct ProfileItemCellViewModel {
    enum ItemType: CaseIterable {
        case repositories
        case starred
        case organizations
        case subscriptions
    }

    let type: ItemType
}

class ProfileItemCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ProfileItemCell: ConfigurableCell {
    func configure(viewModel: ProfileItemCellViewModel) {
        switch viewModel.type {
        case .repositories:
            itemImageView.image = .repositories
            itemNameLabel.text = .repositories
        case .starred:
            itemImageView.image = .starred
            itemNameLabel.text = .starred
        case .organizations:
            itemImageView.image = .organizations
            itemNameLabel.text = .organizations
        case .subscriptions:
            itemImageView.image = .starred
            itemNameLabel.text = "Subscriptions"
        }
    }
}
