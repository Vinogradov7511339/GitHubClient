//
//  ProfileHeaderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

protocol ProfileHeaderCellDelegate: AnyObject {
    func followersTouched()
    func followingTouched()
}

class ProfileHeaderCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!

    weak var delegate: ProfileHeaderCellDelegate?

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }

    @IBAction func followersTouched(_ sender: UIButton) {
        delegate?.followersTouched()
    }

    @IBAction func followingTouched(_ sender: UIButton) {
        delegate?.followingTouched()
    }
}

// MARK: - ConfigurableCell
extension ProfileHeaderCell: ConfigurableCell {
    func configure(viewModel: UserProfile) {
        avatarImageView.set(url: viewModel.user.avatarUrl)
        nameLabel.text = viewModel.user.name
        loginLabel.text = viewModel.user.login
        followersCountLabel.text = viewModel.followersCount.roundedWithAbbreviations
        followingCountLabel.text = viewModel.followingCount.roundedWithAbbreviations
        if let company = viewModel.company {
            add(company: company)
        }
        if let link = viewModel.userBlogUrl {
            add(link: link.absoluteString)
        }
        if let email = viewModel.userEmail {
            add(email: email)
        }
        add(followers: viewModel.followersCount, following: viewModel.followingCount)
    }

    func add(email: String) {
        let image = UIImage(systemName: "mail")?.withTintColor(.secondaryLabel)
        add(text: email, image: image)
    }

    func add(company: String) {
        let image = UIImage(systemName: "building.2")?.withTintColor(.secondaryLabel)
        add(text: company, image: image)
    }

    func add(link: String) {
        let image = UIImage(systemName: "link")?.withTintColor(.secondaryLabel)
        add(text: link, image: image)
    }

    func add(text: String, image: UIImage?) {
        let attachment = NSTextAttachment(image: image!)
        let attributedStr = NSMutableAttributedString(attachment: attachment)
        let emailStr = NSAttributedString(string: text, attributes: [.font: UIFont.boldSystemFont(ofSize: 14.0)])
        attributedStr.append(emailStr)

        let button = UIButton()
        button.setAttributedTitle(attributedStr, for: .normal)
        infoStackView.addArrangedSubview(button)
        button.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }

    func add(followers: Int, following: Int) {

    }
}
