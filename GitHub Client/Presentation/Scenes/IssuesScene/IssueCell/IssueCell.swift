//
//  IssueCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

class IssueCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var authorAvatarImageView: WebImageView!
    @IBOutlet weak var authorLoginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    @IBOutlet weak var statusBGView: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}

// MARK: - ConfigurableCell
extension IssueCell: ConfigurableCell {
    func configure(viewModel: Issue) {
        authorAvatarImageView.set(url: viewModel.user.avatarUrl)
        authorLoginLabel.text = viewModel.user.login
        nameLabel.text = viewModel.commentsURL.absoluteString
        bodyLabel.text = viewModel.title
        statusLabel.text = viewModel.state
        commentsCountLabel.text = "\(viewModel.commentsCount)"
    }
}
