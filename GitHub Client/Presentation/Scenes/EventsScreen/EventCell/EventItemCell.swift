//
//  EventItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.09.2021.
//

import UIKit

class EventItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var eventTypeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension EventItemCell: ConfigurableCell {
    func configure(viewModel: Event) {
        titleLabel.attributedText = viewModel.fullTitle
        createdAtLabel.text = viewModel.createdAt.timeAgoDisplay()
        eventTypeImageView.image = viewModel.image
    }
}
