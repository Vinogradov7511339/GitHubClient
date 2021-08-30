//
//  UserActionCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

class UserActionCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension UserActionCell: ConfigurableCell {
    func configure(viewModel: UserActionsRowType) {
        let image: UIImage?
        let title: String
        switch viewModel {
        case .repositories:
            title = NSLocalizedString("Repositories", comment: "")
            image = UIImage.UserProfile.repositories
        case .starred:
            title = NSLocalizedString("Starred", comment: "")
            image = UIImage.UserProfile.starred
        case .gists:
            title = NSLocalizedString("Gists", comment: "")
            image = UIImage.UserProfile.gists
        case .events:
            title = NSLocalizedString("Events", comment: "")
            image = UIImage.UserProfile.events
        }
        itemTitleLabel.text = title
        itemImageView.image = image
    }
}
