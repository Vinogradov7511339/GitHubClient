//
//  ProfileHeaderTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

class ProfileHeaderCellViewModel {
    let profile: UserProfile
    
    init(_ profile: UserProfile) {
        self.profile = profile
    }
}

class ProfileHeaderTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ProfileHeaderTableViewCell: ConfigurableCell {
    func configure(viewModel: ProfileHeaderCellViewModel) {
        let profile = viewModel.profile
        avatarImageView.set(url: profile.avatar_url)
        nameLabel.text = profile.name
        loginLabel.text = profile.login
        descriptionLabel.text = profile.bio ?? ""
        companyLabel.text = profile.company
        locationLabel.text = profile.location
        linkLabel.text = "\(profile.url)"
        mailLabel.text = profile.email
        followersLabel.text = "\(profile.followers!) followers"
        followingLabel.text = "\(profile.following!) following"
        
        statusView.isHidden = true
        followButton.isHidden = true
    }
}

