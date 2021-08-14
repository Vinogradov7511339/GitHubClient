//
//  CommitCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

class CommitCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var authorAvatarImageView: WebImageView!
    @IBOutlet weak var authorLoginLabel: UILabel!
    @IBOutlet weak var commiterLoginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var statusBGView: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CommitCell: ConfigurableCell {
    func configure(viewModel: Commit) {
        authorAvatarImageView.set(url: viewModel.author.avatarUrl)
        authorLoginLabel.text = viewModel.author.login
        commiterLoginLabel.text = viewModel.commiter.login
        messageLabel.text = viewModel.message
        commentsCountLabel.text = "\(viewModel.commentsCount)"
    }
}
