//
//  UserActivityItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class UserActivityItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var eventTypeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserActivityItemCell: ConfigurableCell {
    func configure(viewModel: Event) {
        eventTypeImageView.image = viewModel.image
        titleLabel.attributedText = viewModel.fullTitle
        createdAtLabel.text = viewModel.createdAt.timeAgoDisplay()
    }
}
