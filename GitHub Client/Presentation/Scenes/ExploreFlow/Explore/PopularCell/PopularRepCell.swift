//
//  PopularRepCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

class PopularRepCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var ownerLoginLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension PopularRepCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        repNameLabel.text = viewModel.name
        avatarImageView.set(url: viewModel.owner.avatarUrl)
        ownerLoginLabel.text = viewModel.owner.login
        descriptionLabel.text = viewModel.description ?? ""

        starsCountLabel.text = viewModel.starsCount.roundedWithAbbreviations
        forksCountLabel.text = viewModel.forksCount.roundedWithAbbreviations
    }
}
