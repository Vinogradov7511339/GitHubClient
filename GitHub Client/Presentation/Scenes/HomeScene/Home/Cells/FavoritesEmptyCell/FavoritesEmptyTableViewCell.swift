//
//  FavoritesEmptyTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

struct FavoritesEmptyCellViewModel {}

protocol FavoritesEmptyCellDelegate: AnyObject {
    func addFavoritesButtonTouchUpInside()
}

class FavoritesEmptyTableViewCell: BaseTableViewCell, NibLoadable {

    weak var delegate: FavoritesEmptyCellDelegate?

    @IBAction func addFavoritesButtonTouchUpInside(_ sender: UIButton) {
        delegate?.addFavoritesButtonTouchUpInside()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
    }
}

extension FavoritesEmptyTableViewCell: ConfigurableCell {
    func configure(viewModel: FavoritesEmptyCellViewModel) {}
}
