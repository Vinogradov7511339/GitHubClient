//
//  CommitInfoAuthorCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

class CommitInfoAuthorCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var authorAvatarImageView: WebImageView!
    @IBOutlet weak var authorLoginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CommitInfoAuthorCell: ConfigurableCell {
    func configure(viewModel: Commit) {
        authorAvatarImageView.set(url: viewModel.author.avatarUrl)
        authorLoginLabel.text = viewModel.author.login
        createdAtLabel.text = viewModel.createdAt?.timeAgoDisplay()
    }
}
