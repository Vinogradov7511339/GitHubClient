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
    func favoritesButtonTouchUpInside()
}

class RepositoryHeaderTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var linkStackView: UIStackView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var starsAndFolksStackView: UIStackView!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var watchButton: UIButton!

    weak var delegate: RepositoryHeaderTableViewCellDelegate?

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }

    @IBAction func favoritesButtonTouchUpInside(_ sender: UIButton) {
        delegate?.favoritesButtonTouchUpInside()
    }
}

extension RepositoryHeaderTableViewCell: ConfigurableCell {
    func configure(viewModel: RepositoryDetailsHeaderCellViewModel) {
        let repository = viewModel.repository
        avatarImageView.set(url: viewModel.repository.owner.avatarUrl)
        ownerNameLabel.text = repository.owner.login
        repositoryNameLabel.text = repository.name

        let starts = repository.starsCount.roundedWithAbbreviations
        starsCountLabel.text = "\(starts) Stars"

        let forks = repository.forksCount.roundedWithAbbreviations
        forksCountLabel.text = "\(forks) Forks"

        if let description = repository.description, !description.isEmpty {
            aboutLabel.isHidden = false
            aboutLabel.text = repository.description ?? ""
        } else {
            aboutLabel.isHidden = true
        }

        if let homePage = repository.homePage {
            linkLabel.text = homePage.absoluteString
            linkStackView.isHidden = false
        } else {
            linkStackView.isHidden = true
        }
    }
}
