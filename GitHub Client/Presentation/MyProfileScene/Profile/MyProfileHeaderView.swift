//
//  MyProfileHeaderView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import UIKit

final class MyProfileHeaderView: UIView {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starredCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var nameLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!

    func setProfile(_ user: User) {
        avatarImageView.set(url: user.avatarUrl)
        loginLabel.text = user.login
        if let name = user.name {
            nameLabel.text = name
            nameLabel.isHidden = false
        } else {
            nameLabel.isHidden = true
        }
    }

    func updateHeight(_ percent: CGFloat) {
        let newHeight = max(32.0, 64.0 * percent)
        imageViewHeightConstraint.constant = newHeight
        imageViewWidthConstraint.constant = newHeight
        imageViewTopConstraint.constant = max(8.0, (24.0 * percent))

        stackViewHeightConstraint.constant = 60 * percent
        nameLabelTopConstraint.constant = max(4.0, (90 * percent))
        stackView.alpha = percent

        let centerX = (1.0 - percent) * (bounds.width / 2.0 - imageViewWidthConstraint.constant)
        imageViewCenterXConstraint.constant = -centerX
    }

    class func instanceFromNib() -> MyProfileHeaderView {
        if let view = Bundle.main.loadNibNamed("MyProfileHeaderView",
                                               owner: self,
                                               options: nil)?[0] as? MyProfileHeaderView {
            return view
        } else {
            fatalError()
        }
    }
}
