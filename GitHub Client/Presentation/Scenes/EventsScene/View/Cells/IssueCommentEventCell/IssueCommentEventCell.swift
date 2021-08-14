//
//  IssueCommentEventCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

class IssueCommentEventCell: BaseCollectionViewCell, NibLoadable {
    @IBOutlet weak var commenterAvatarImageView: WebImageView!
    @IBOutlet weak var commenterLoginLabel: UILabel!
    @IBOutlet weak var authorAvatarImageView: WebImageView!    
    @IBOutlet weak var authorLoginLabel: UILabel!
    @IBOutlet weak var issueNameLabel: UILabel!
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension IssueCommentEventCell: ConfigurableCell {
    func configure(viewModel: Event) {
        commenterAvatarImageView.set(url: viewModel.actor.avatarUrl)
        commenterLoginLabel.text = viewModel.actor.login
        switch viewModel.eventPayload {
        case .issueCommentEvent(let model):
            authorAvatarImageView.set(url: model.issue.user.avatarUrl)
            authorLoginLabel.text = model.issue.user.login
            issueNameLabel.text = "\(model.issue.number)"
            issueTitleLabel.text = model.issue.title
            commentLabel.text = model.comment.body
        default:
            break
        }
    }
}
