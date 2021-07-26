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

protocol ProfileHeaderTableViewCellDelegate: AnyObject {
    func followersButtonTouchUpInside()
    func followingButtonTouchUpInside()
    func linkButtonTouchUpInside()
    func mailButtonTouchUpInside()
}

class ProfileHeaderTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusDescrptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locattionImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var companiAndLocationStackView: UIStackView!
    @IBOutlet weak var linkStackView: UIStackView!
    @IBOutlet weak var mailStackView: UIStackView!
    
    weak var delegate: ProfileHeaderTableViewCellDelegate?
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
    @IBAction func followersButtonTouchUpInside(_ sender: UIButton) {
        delegate?.followersButtonTouchUpInside()
    }
    
    @IBAction func followingButtonTouchUpInside(_ sender: UIButton) {
        delegate?.followingButtonTouchUpInside()
    }
    @IBAction func linkButtonTouchUpInside(_ sender: UIButton) {
        delegate?.linkButtonTouchUpInside()
    }
    @IBAction func mailButtonTouchUpInside(_ sender: UIButton) {
        delegate?.mailButtonTouchUpInside()
    }
}

// MARK: - ConfigurableCell
extension ProfileHeaderTableViewCell: ConfigurableCell {
    func configure(viewModel: ProfileHeaderCellViewModel) {
        let profile = viewModel.profile
        avatarImageView.set(url: profile.avatar_url)
        nameLabel.text = profile.name
        loginLabel.text = profile.login
        if let bio = profile.bio {
            descriptionLabel.isHidden = false
            descriptionLabel.text = bio
        } else {
            descriptionLabel.isHidden = true
        }
        
        if let company = profile.company {
            companyImageView.isHidden = false
            companyLabel.text = company
        } else {
            companyImageView.isHidden = true
        }
        if let location = profile.location {
            locattionImageView.isHidden = false
            locationLabel.text = location
        } else {
            locattionImageView.isHidden = true
        }
        companiAndLocationStackView.isHidden = profile.company == nil && profile.location == nil
        
        if let homePageUrl = profile.html_url {
            linkButton.setTitle("\(homePageUrl)", for: .normal)
            linkStackView.isHidden = false
        } else {
            linkStackView.isHidden = true
        }
        
        if let mail = profile.email {
            mailButton.setTitle(mail, for: .normal)
            mailStackView.isHidden = false
        } else {
            mailStackView.isHidden = true
        }
        
        followersButton.setTitle("\(profile.followers ?? 0) followers", for: .normal)
        followingButton.setTitle("\(profile.following ?? 0) following", for: .normal)
        
        statusView.isHidden = true
        followButton.isHidden = true
    }
}

