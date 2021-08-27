//
//  SmallCategoryCollectionViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct SmallCategoryCellViewModel {
    
    let avatarUrl: URL?
    let login: String
    let followers: String

    init(profile: UserDetailsResponseDTO) {
        avatarUrl = profile.avatarUrl
        login = profile.login
        followers = "\(profile.followers ?? 0) followers"
    }
}

class SmallCategoryCollectionViewCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageVIew: WebImageView!

    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userFollowersCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension SmallCategoryCollectionViewCell: ConfigurableCell {
    func configure(viewModel: SmallCategoryCellViewModel) {
    }
}
