//
//  MenuItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

struct MenuItemViewModel {
    let image: UIImage?
    let name: String
    let itemsCount: Int

    enum ItemType {
        case starred
        case gists(Int)
        case events
        case subscriptions
        case organizations

        var viewModel: MenuItemViewModel {
            switch self {
            case .starred:
                return MenuItemViewModel(image: .starred,
                                         name: "Starred",
                                         itemsCount: 0)
            case .gists(let count):
                return MenuItemViewModel(image: .starred,
                                         name: "Gists",
                                         itemsCount: count)
            case .events:
                return MenuItemViewModel(image: .starred,
                                         name: "Events",
                                         itemsCount: 0)
            case .subscriptions:
                return MenuItemViewModel(image: .starred,
                                         name: "Subscriptions",
                                         itemsCount: 0)
            case .organizations:
                return MenuItemViewModel(image: .starred,
                                         name: "Organizations",
                                         itemsCount: 0)
            }
        }
    }
}

class MenuItemCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var countContainer: UIView!
    @IBOutlet weak var itemCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARRK: - ConfigurableCell
extension MenuItemCell: ConfigurableCell {
    func configure(viewModel: MenuItemViewModel) {
        itemImageView.image = viewModel.image
        itemName.text = viewModel.name
        countContainer.isHidden = viewModel.itemsCount == 0
        itemCountLabel.text = "\(viewModel.itemsCount)"
    }
}
