//
//  PRHeaderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol PRHeaderCellDelegate: AnyObject {}

class PRHeaderCell: BaseTableViewCell, NibLoadable {

    // MARK: - Delegate

    weak var delegate: PRHeaderCellDelegate?

    // MARK: - Views

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var ownerLoginButton: UIButton!
    @IBOutlet weak var repositoryNameButton: UIButton!
    @IBOutlet weak var prNumberLabel: UILabel!
    @IBOutlet weak var prTitleLabel: UILabel!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var headerBranchLabel: UILabel!
    @IBOutlet weak var baseBranchLabel: UILabel!

    // MARK: - Configure

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension PRHeaderCell: ConfigurableCell {
    func configure(viewModel: PullRequestDetails) {
        avatarImageView.set(url: viewModel.head.user.avatarUrl)
        ownerLoginButton.setTitle(viewModel.base.repo.name, for: .normal)
        repositoryNameButton.setTitle(viewModel.base.repo.owner.login, for: .normal)
        prNumberLabel.text = "#\(viewModel.number)"
        prTitleLabel.text = viewModel.title
        configreStateBadge(viewModel.state)
        headerBranchLabel.text = viewModel.head.label
        baseBranchLabel.text = viewModel.base.label
    }

    func configreStateBadge(_ state: PullRequestState) {
        stateLabel.text = state.rawValue
        switch state {
        case .open:
            stateView.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            stateImageView.tintColor = .systemGreen
            stateLabel.textColor = .systemGreen
            stateImageView.image = UIImage(named: "todo")
        case .close:
            stateView.backgroundColor = .systemRed.withAlphaComponent(0.2)
            stateImageView.tintColor = .systemRed
            stateLabel.textColor = .systemRed
            stateImageView.image = UIImage(named: "todo")
        case .unknown:
            stateView.backgroundColor = .systemGray.withAlphaComponent(0.2)
            stateImageView.tintColor = .systemGray
            stateLabel.textColor = .systemGray
            stateImageView.image = UIImage(named: "todo")
        }
    }
}
