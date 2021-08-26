//
//  RepositoryDetailsHeaderTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import UIKit

struct RepositoryDetailsHeaderCellViewModel {
    let repository: Repository
}

protocol RepositoryHeaderTableViewCellDelegate: AnyObject {
    func starsButtonTapped()
    func forksButtonTapped()
    func starButtonTapped()
    func subscribeButtonTapped()
}

class RepositoryHeaderTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var starsAndFolksStackView: UIStackView!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    
    weak var delegate: RepositoryHeaderTableViewCellDelegate?

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }

    @IBAction func starsButtonTapped(_ sender: UIButton) {
    }

    @IBAction func forksButtonTapped(_ sender: UIButton) {
    }
    @IBAction func starButtonTapped(_ sender: UIButton) {
    }
    @IBAction func subscribeButtonTapped(_ sender: UIButton) {
    }
}

extension RepositoryHeaderTableViewCell: ConfigurableCell {
    func configure(viewModel: RepositoryDetailsHeaderCellViewModel) {
        let repository = viewModel.repository
        avatarImageView.set(url: viewModel.repository.owner.avatarUrl)
        ownerNameLabel.text = repository.owner.login

        starsCountLabel.text = repository.starsCount.roundedWithAbbreviations
        forksCountLabel.text = repository.forksCount.roundedWithAbbreviations

        if let description = repository.description, !description.isEmpty {
            aboutLabel.isHidden = false
            aboutLabel.text = repository.description ?? ""
        } else {
            aboutLabel.isHidden = true
        }
    }
}
