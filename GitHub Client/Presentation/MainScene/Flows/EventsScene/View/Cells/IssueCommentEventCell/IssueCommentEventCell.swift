//
//  IssueCommentEventCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

class IssueCommentEventCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
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
        userAvatarImageView.set(url: viewModel.actor.avatarUrl)
        createdAtLabel.text = viewModel.createdAt.timeAgoDisplay()
        switch viewModel.eventPayload {
        case .issueCommentEvent(let model):
            actionLabel.attributedText = attributedText(user: viewModel.actor.login, issue: model.issue.number)
            issueTitleLabel.text = model.issue.title
            commentLabel.text = model.comment.body
        default:
            break
        }
    }

    private func attributedText(user: String, issue: Int) -> NSAttributedString {
        let userAttr = NSAttributedString(string: user,
                                           attributes: [.foregroundColor: UIColor.link])
        let commentedAttr = NSAttributedString(string: " commented ",
                                           attributes: [.foregroundColor: UIColor.secondaryLabel])
        let issueAttr = NSAttributedString(string: "#\(issue)",
                                               attributes: [.foregroundColor: UIColor.link])
        let attrStr = NSMutableAttributedString()
        attrStr.append(userAttr)
        attrStr.append(commentedAttr)
        attrStr.append(issueAttr)
        return attrStr
    }
}
