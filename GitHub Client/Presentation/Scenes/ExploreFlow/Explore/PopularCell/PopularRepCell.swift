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
    @IBOutlet weak var badgesStackView: UIStackView!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension PopularRepCell: ConfigurableCell {
    func configure(viewModel: Repository) {
        badgesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        repNameLabel.text = viewModel.name
        avatarImageView.set(url: viewModel.owner.avatarUrl)
        ownerLoginLabel.text = viewModel.owner.login
        descriptionLabel.text = viewModel.description ?? ""

        if viewModel.starsCount > 0 {
            addBadge(UIImage.RepListItem.stars, tint: .systemYellow, count: viewModel.starsCount)
        }
        if viewModel.forksCount > 0 {
            addBadge(UIImage.RepListItem.forks, tint: .systemPurple, count: viewModel.forksCount)
        }
//        if viewModel.openIssuesCount > 0 {
//            addBadge(UIImage.RepListItem.issues, tint: .systemGreen, count: viewModel.openIssuesCount)
//        }
        if viewModel.watchersCount > 0 {
            addBadge(UIImage.RepListItem.watchers, tint: .systemBlue, count: viewModel.watchersCount)
        }
    }

    func addBadge(_ image: UIImage?, tint: UIColor, count: Int) {
        let imageView = UIImageView(image: image)
        imageView.tintColor = tint
        let label = UILabel()
        label.textColor = .secondaryLabel
        let formattedCount = count.roundedWithAbbreviations
        label.text = "\(formattedCount)  "
        badgesStackView.addArrangedSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        badgesStackView.addArrangedSubview(label)
    }
}
