//
//  MyProfileActivityItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.09.2021.
//

import UIKit

class MyProfileActivityItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension MyProfileActivityItemCell: ConfigurableCell {
    func configure(viewModel: Event) {
        eventImageView.image = viewModel.image
        eventTitleLabel.attributedText = viewModel.fullTitle
        createdAtLabel.text = viewModel.createdAt.timeAgoDisplay()
    }
}
