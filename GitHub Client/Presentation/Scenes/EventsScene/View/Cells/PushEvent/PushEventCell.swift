//
//  PushEventCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

class PushEventCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
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
        userAvatarImageView.set(url: viewModel.actor.avatarUrl)
        userLoginLabel.text = viewModel.actor.login
        repositoryNameLabel.text = viewModel.repository.name

        switch viewModel.eventPayload {
        case .pushEvent(let model):
            branchNameLabel.text = model.branch
            commitsCountLabel.text = "\(model.commits.count) commits to"
            for commit in model.commits {
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.distribution = .equalCentering
                let shaLabel = UILabel()
                shaLabel.textColor = .link
                shaLabel.text = commit.sha
                let commentLabel = UILabel()
                commentLabel.textColor = .secondaryLabel
                commentLabel.text = commit.message
                stackView.addArrangedSubview(shaLabel)
                stackView.addArrangedSubview(commentLabel)
                commitsStackView.addArrangedSubview(stackView)
            }
        default:
            break
        }
    }
}
