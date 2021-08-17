//
//  HomeWidgetCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

class HomeWidgetCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension HomeWidgetCell: ConfigurableCell {
    func configure(viewModel: HomeWidget) {
        switch viewModel {
        case .issues:
            iconImageView.image = UIImage.issue
            iconImageView.tintColor = .systemGreen
            nameLabel.text = String.issue
        }
    }
}
