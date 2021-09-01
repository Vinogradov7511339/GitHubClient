//
//  UserHeaderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

protocol UserHeaderCellDelegate: AnyObject {
    func followersButtonTapped()
    func followingButtonTapped()
}

class UserHeaderCell: BaseTableViewCell, NibLoadable {

    // MARK: - Public variables

    weak var delegate: UserHeaderCellDelegate?

    // MARK: - Views

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var userInfoStackView: UIStackView!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    // MARK: - Actions

    @IBAction func followersButtonTapped(_ sender: UIButton) {
        delegate?.followersButtonTapped()
    }

    @IBAction func followingButtonTouched(_ sender: UIButton) {
        delegate?.followingButtonTapped()
    }

    // MARK: - Lifecycle

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserHeaderCell: ConfigurableCell {
    func configure(viewModel: UserProfile) {
        avatarImageView.set(url: viewModel.user.avatarUrl)
        loginLabel.text = viewModel.user.login
        followersCountLabel.text = viewModel.followersCount.roundedWithAbbreviations
        followingCountLabel.text = viewModel.followingCount.roundedWithAbbreviations
    }
}
