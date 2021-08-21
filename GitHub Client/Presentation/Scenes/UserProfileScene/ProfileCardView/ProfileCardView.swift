//
//  ProfileCardView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

protocol ProfileCardViewDelegate: AnyObject {
    func backButtonTouchUpInside()
    func repositoriesButtonTouchUpInside()
    func followersButtonTouchUpInside()
    func followingsButtonTouchUpInside()
    func linkButtonTouchUpInside(link: URL)
    func emailButtonTouchUpInside(email: String)
}

final class ProfileCardView: UIView {

    // MARK: - @IBOutlet's

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var repositoriesCountLabel: UILabel!

    // MARK: - Constraint's

    @IBOutlet weak var avatarWidth: NSLayoutConstraint!
    @IBOutlet weak var avatarHeight: NSLayoutConstraint!
    @IBOutlet weak var avatarTop: NSLayoutConstraint!
    @IBOutlet weak var avatarLeading: NSLayoutConstraint!

    // MARK: - @IBAction's

    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        delegate?.backButtonTouchUpInside()
    }

    @IBAction func repositoriesButtonTouchUpInside(_ sender: UIButton) {
        delegate?.repositoriesButtonTouchUpInside()
    }

    @IBAction func followersButtonTouchUpInside(_ sender: UIButton) {
        delegate?.followersButtonTouchUpInside()
    }

    @IBAction func followingsButtonTouchUpInside(_ sender: UIButton) {
        delegate?.followingsButtonTouchUpInside()
    }

    @IBAction func linkButtonTouchUpInside(_ sender: UIButton) {
        guard let link = user?.userBlogUrl else { return }
        delegate?.linkButtonTouchUpInside(link: link)
    }

    @IBAction func emailButtonTouchUpInside(_ sender: UIButton) {
        guard let email = user?.userEmail else { return }
        delegate?.emailButtonTouchUpInside(email: email)
    }

    weak var delegate: ProfileCardViewDelegate?
    private var user: UserProfile?

    func setProfile(_ user: UserProfile) {
        self.user = user
        loginLabel.text = user.user.login
        avatarImageView.set(url: user.user.avatarUrl)
        followersCountLabel.text = "\(user.followersCount)"
        followingCountLabel.text = "\(user.followingCount)"
        repositoriesCountLabel.text = "\(user.repositoriesCount)"
        if let name = user.user.name {
            nameLabel.isHidden = false
            nameLabel.text = name
        } else {
            nameLabel.isHidden = true
        }
        if let company = user.company {
            companyButton.isHidden = false
            companyButton.setTitle(company, for: .normal)
        } else {
            companyButton.isHidden = true
        }
        if let location = user.location {
            locationButton.isHidden = false
            locationButton.setTitle(location, for: .normal)
        } else {
            locationButton.isHidden = true
        }
        if let link = user.userBlogUrl {
            linkButton.isHidden = false
            linkButton.setTitle(link.absoluteString, for: .normal)
        } else {
            linkButton.isHidden = true
        }
        if let email = user.userEmail {
            emailButton.isHidden = false
            emailButton.setTitle(email, for: .normal)
        } else {
            emailButton.isHidden = true
        }
    }

    func updateHeight(_ percent: CGFloat) {
        print(percent)
        avatarWidth.constant = max(12, (64.0 * percent))
        avatarHeight.constant = max(12, (64.0 * percent))
        avatarTop.constant =  max(8.0, (48.0 * percent))
//        avatarLeading.constant = 36.0 * (1 - percent)

        cardView.alpha = percent
        infoStackView.alpha = percent
    }

    class func instanceFromNib() -> ProfileCardView {
        if let view = Bundle.main.loadNibNamed("ProfileCardView", owner: self, options: nil)?[0] as? ProfileCardView {
            return view
        } else {
            fatalError()
        }
    }
}

// MARK: - Constants
extension ProfileCardView {
    enum Const {
        static let maxHeight: CGFloat = 358.0
    }
}
