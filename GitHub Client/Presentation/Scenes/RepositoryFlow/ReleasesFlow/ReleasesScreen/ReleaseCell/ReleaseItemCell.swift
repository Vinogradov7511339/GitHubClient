//
//  ReleaseItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

class ReleaseItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ReleaseItemCell: ConfigurableCell {
    func configure(viewModel: Release) {
        versionLabel.text = viewModel.tagName
        avatarImageView.set(url: viewModel.author.avatarUrl)
        loginButton.setTitle(viewModel.author.login, for: .normal)
        createdAtLabel.text = "released this \(viewModel.publishedAt?.timeAgoDisplay() ?? "")"
    }
}
