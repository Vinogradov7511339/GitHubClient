//
//  PRHeaderCommentCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

class PRHeaderCommentCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - Configure
extension PRHeaderCommentCell: ConfigurableCell {
    func configure(viewModel: PullRequestDetails) {
        userAvatarImageView.set(url: viewModel.user.avatarUrl)
        loginLabel.text = viewModel.user.login
        bodyLabel.text = viewModel.body
        if let updatedAt = viewModel.updatedAt {
            createdAtLabel.text = "Updated \(updatedAt.timeAgoDisplay())"
        } else if let createdAt = viewModel.createdAt {
            createdAtLabel.text = "Created \(createdAt.timeAgoDisplay())"
        }
        moreButton.isHidden = bodyLabel.calculateMaxLines() <= 3
    }
}
