//
//  NotificationCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import UIKit

class NotificationCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension NotificationCell: ConfigurableCell {
    func configure(viewModel: EventNotification) {
        let notification = viewModel.notification

        nameLabel.text = name(viewModel)
        titleLabel.text = notification.subject.title

        if let updatedAt = viewModel.updatedAt?.timeAgoDisplay() {
            createdAtLabel.text = updatedAt
        }
    }

    func name(_ viewModel: EventNotification) -> String {
        let owner = viewModel.notification.repository.owner.login
        let repository = viewModel.notification.repository.name
        switch viewModel.type {
        case .issue:
            let number = viewModel.notification.subject.url?.pathComponents.last ?? ""
            return "\(owner) / \(repository) #\(number)"
        case .unknown:
            let type = viewModel.notification.subject.type
            return "\(owner) / \(repository) \(type)"
        }
    }
}
