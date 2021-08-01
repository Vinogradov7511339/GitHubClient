//
//  UserTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import UIKit

class UserTableViewCell: BaseTableViewCell, NibLoadable {
    
    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension UserTableViewCell: ConfigurableCell {
    func configure(viewModel: UserProfile) {
        avatarImageView.set(url: viewModel.avatarUrl)
        loginLabel.text = viewModel.login ?? ""
        if let name = viewModel.name {
            nameLabel.isHidden = false
            nameLabel.text = name
        } else {
            nameLabel.isHidden = true
        }
        if let bio = viewModel.bio {
            bioLabel.isHidden = false
            bioLabel.text = bio
        } else {
            bioLabel.isHidden = true
        }
    }
}
