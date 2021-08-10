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

//        starsCountLabel.text = "\(repository.stargazersCount ?? 0) Stars"
//        forksCountLabel.text = "\(repository.forksCount ?? 0) Forks"

        if let description = repository.description, !description.isEmpty {
            aboutLabel.isHidden = false
            aboutLabel.text = repository.description ?? ""
        } else {
            aboutLabel.isHidden = true
        }

//        if let url = repository.url {
//            linkLabel.text = url.absoluteString
//            linkStackView.isHidden = false
//        } else {
//            linkStackView.isHidden = true
//        }
    }
}
