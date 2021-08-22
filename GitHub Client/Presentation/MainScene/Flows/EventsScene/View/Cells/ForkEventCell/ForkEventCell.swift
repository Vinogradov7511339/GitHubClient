//
//  ForkEventCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 16.08.2021.
//

import UIKit

class ForkEventCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ForkEventCell: ConfigurableCell {
    func configure(viewModel: Event) {
        userAvatarImageView.set(url: viewModel.actor.avatarUrl)
        createdAtLabel.text = viewModel.createdAt.timeAgoDisplay()
        let action: NSAttributedString
        switch viewModel.eventPayload {
        case .watchEvent(_):
            action = attributedText(login: viewModel.actor.login, event: " watched ", repository: viewModel.repository.name)
        case .createEvent(_):
            action = attributedText(login: viewModel.actor.login, event: " created ", repository: viewModel.repository.name)
        case .forkEvent(_):
            action = attributedText(login: viewModel.actor.login, event: " forked ", repository: viewModel.repository.name)
        default:
            action = NSAttributedString(string: "")
        }
        actionLabel.attributedText = action
    }

    private func attributedText(login: String,
                                event: String,
                                repository: String) -> NSAttributedString {
        let loginAttr = NSAttributedString(string: login,
                                           attributes: [.foregroundColor: UIColor.link])
        let eventAttr = NSAttributedString(string: event,
                                           attributes: [.foregroundColor: UIColor.secondaryLabel])
        let repositoryAttr = NSAttributedString(string: repository,
                                               attributes: [.foregroundColor: UIColor.link])
        let attrStr = NSMutableAttributedString()
        attrStr.append(loginAttr)
        attrStr.append(eventAttr)
        attrStr.append(repositoryAttr)
        return attrStr
    }
}
