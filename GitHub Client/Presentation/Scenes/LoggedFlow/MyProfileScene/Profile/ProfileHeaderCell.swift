//
//  ProfileHeaderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit


protocol ProfileHeaderCellDelegate: AnyObject {
    func followersButtonTapped()
    func followingButtonTapped()
    func editProfileButtonTapped()
}

class ProfileHeaderCell: BaseTableViewCell, NibLoadable {

    // MARK: - Public variables

    weak var delegate: ProfileHeaderCellDelegate?

    // MARK: - Views

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!

    // MARK: - Actions

    @IBAction func followersButtonTouched(_ sender: UIButton) {
        delegate?.followersButtonTapped()
    }

    @IBAction func followingButtonTouched(_ sender: UIButton) {
        delegate?.followingButtonTapped()
    }

    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        delegate?.editProfileButtonTapped()
    }

    // MARK: - Lifecycle

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ProfileHeaderCell: ConfigurableCell {
    func configure(viewModel: UserProfile) {
        avatarImageView.set(url: viewModel.user.avatarUrl)
        loginLabel.text = viewModel.user.login
        followersCountLabel.text = viewModel.followersCount.roundedWithAbbreviations
        followingCountLabel.text = viewModel.followingCount.roundedWithAbbreviations
        fillInfo(viewModel)
    }

    private func fillInfo(_ profile: UserProfile) {
        infoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if let email = profile.userEmail {
            addItem(email)
        }
        if let blog = profile.userBlogUrl {
            addItem(blog.absoluteString)
        }
        if let location = profile.location {
            addItem(location)
        }
        if let company = profile.company {
            addItem(company)
        }
    }

    private func addItem(_ text: String) {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14.0)
        label.text = text
        infoStackView.addArrangedSubview(label)
    }
}
