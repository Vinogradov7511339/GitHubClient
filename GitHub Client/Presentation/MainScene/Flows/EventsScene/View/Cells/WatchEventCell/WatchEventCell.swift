//
//  WatchEventCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

class WatchEventCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!


    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension WatchEventCell: ConfigurableCell {
    func configure(viewModel: Event) {
        userAvatarImageView.set(url: viewModel.actor.avatarUrl)
        userLoginLabel.text = viewModel.actor.login
        repositoryNameLabel.text = viewModel.repository.name
    }
}
