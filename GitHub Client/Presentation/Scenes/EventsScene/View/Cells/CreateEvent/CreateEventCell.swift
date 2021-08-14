//
//  CreateEventCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

class CreateEventCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - Configure
extension CreateEventCell: ConfigurableCell {
    func configure(viewModel: Event) {
        userAvatarImageView.set(url: viewModel.actor.avatarUrl)
        userLoginLabel.text = viewModel.actor.login
        repositoryNameLabel.text = viewModel.repository.name
        
        switch viewModel.eventPayload {
        case .createEvent(let model):
            branchNameLabel.text = model.branch
            repositoryDescriptionLabel.text = model.description
        default:
            break
        }
    }
}
