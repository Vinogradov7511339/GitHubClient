//
//  PushEventCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

class PushEventCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var commitsCountLabel: UILabel!
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var commitsStackView: UIStackView!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension PushEventCell: ConfigurableCell {
    func configure(viewModel: Event) {
        commitsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        userAvatarImageView.set(url: viewModel.actor.avatarUrl)
        createdAtLabel.text = viewModel.createdAt.timeAgoDisplay()
        actionLabel.attributedText = attributedText(user: viewModel.actor.login, repository: viewModel.repository.name)
        switch viewModel.eventPayload {
        case .pushEvent(let model):
            branchNameLabel.text = model.branch
            commitsCountLabel.text = "\(model.commits.count) commits to"
            let hasHidden = model.commits.count > 2
            let commitsToAdd = hasHidden ? Array(model.commits.prefix(2)) : model.commits
            for commit in commitsToAdd {
                addCommit(commit)
            }
            if hasHidden {
                let button = UIButton()
                button.setTitle("Show more", for: .normal)
                commitsStackView.addArrangedSubview(button)
            }
        default:
            break
        }
    }

    private func addCommit(_ commit: Commit) {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .top
        let shaLabel = UILabel()
        shaLabel.textColor = .link
        let sha = commit.sha.prefix(7)
        shaLabel.text = String(sha)
        let commentLabel = UILabel()
        commentLabel.numberOfLines = 2
        commentLabel.textColor = .secondaryLabel
        commentLabel.text = commit.message
        stackView.addArrangedSubview(shaLabel)
        stackView.addArrangedSubview(commentLabel)
        commitsStackView.addArrangedSubview(stackView)
    }

    private func attributedText(user: String, repository: String) -> NSAttributedString {
        let userAttr = NSAttributedString(string: user,
                                           attributes: [.foregroundColor: UIColor.link])
        let pushedTo = NSLocalizedString(" pushed to ", comment: "")
        let pushedToAttr = NSAttributedString(string: pushedTo,
                                           attributes: [.foregroundColor: UIColor.secondaryLabel])
        let repositoryAttr = NSAttributedString(string: repository,
                                               attributes: [.foregroundColor: UIColor.link])
        let attrStr = NSMutableAttributedString()
        attrStr.append(userAttr)
        attrStr.append(pushedToAttr)
        attrStr.append(repositoryAttr)
        return attrStr
    }
}
