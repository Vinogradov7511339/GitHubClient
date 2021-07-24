//
//  FavoritesEmptyTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

struct FavoritesEmptyCellViewModel {
    
}

class FavoritesEmptyTableViewCell: BaseTableViewCell, NibLoadable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addFavoritesButtonTouchUpInside(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension FavoritesEmptyTableViewCell: ConfigurableCell {
    func configure(viewModel: FavoritesEmptyCellViewModel) {
    }
}
