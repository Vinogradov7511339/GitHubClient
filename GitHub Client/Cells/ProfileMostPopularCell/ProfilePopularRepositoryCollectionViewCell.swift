//
//  ProfilePopularRepositoryCollectionViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import UIKit

class ProfilePopularRepositoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ownerAvatarImageView: WebImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    class var nibName: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        containerView.layer.borderWidth = 0.5
//        containerView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        containerView.layer.cornerRadius = 4.0
//        containerView.backgroundColor = .clear
    }
    
    func configure(with repository: Repository) {
        ownerAvatarImageView.set(url: repository.owner?.avatar_url)
        ownerNameLabel.text = repository.owner!.login
        repositoryNameLabel.text = repository.name
        languageLabel.text = repository.language ?? ""
    }
}
