//
//  RepositoryHeaderView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

protocol RepositoryHeaderDelegate: AnyObject {
    func commitsButtonTouchUpInside()
    func pullRequestsButtonTouchUpInside()
    func eventsButtonTouchUpInside()
    func showIssuesButtonTouchUpIside()
}

final class RepositoryHeaderView: UIView {

    weak var delegate: RepositoryHeaderDelegate?

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!

    @IBAction func commitsButtonTouchUpInside(_ sender: UIButton) {
        delegate?.commitsButtonTouchUpInside()
    }
    @IBAction func pullRequestsButtonTouchUpInside(_ sender: UIButton) {
        delegate?.pullRequestsButtonTouchUpInside()
    }
    @IBAction func eventsButtonTouchUpInside(_ sender: UIButton) {
        delegate?.eventsButtonTouchUpInside()
    }
    @IBAction func showIssuesButtonTouchUpIside(_ sender: UIButton) {
        delegate?.showIssuesButtonTouchUpIside()
    }

    func update(_ repository: Repository) {
        avatarImageView.set(url: repository.owner.avatarUrl)
        loginLabel.text = repository.owner.login
        repositoryNameLabel.text = repository.name
        repositoryDescriptionLabel.text = repository.description
        forksCountLabel.text = "\(repository.forksCount)"
        starsCountLabel.text = "\(repository.starsCount)"
        issuesCountLabel.text = "\(repository.openIssuesCount)"
    }

    class func instanceFromNib() -> RepositoryHeaderView {
        if let view = Bundle.main.loadNibNamed("RepositoryHeaderView", owner: self, options: nil)?[0] as? RepositoryHeaderView {
            return view
        } else {
            fatalError()
        }
    }
}
