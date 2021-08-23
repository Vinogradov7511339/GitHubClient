//
//  SearchRepCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

class SearchRepCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var repDescriptionLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension SearchRepCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        userAvatarImageView.set(url: viewModel.owner.avatarUrl)
        userLoginLabel.text = viewModel.owner.login
        repNameLabel.text = viewModel.name
        repDescriptionLabel.text = viewModel.description
        starsCountLabel.text = viewModel.starsCount.roundedWithAbbreviations
    }
}
