//
//  NotificationCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import UIKit

class NotificationCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var unreadImageView: UIImageView!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension NotificationCell: ConfigurableCell {
    func configure(viewModel: EventNotification) {
//        let image: UIImage?
//        switch viewModel.type {
//        case .issue: image = .issue
//        case .comment: image = .checkmark
//        case .discussion: image = .discussions
//        case .pullRequest: image = .pullRequest
//        }
//        itemImageView.image = image
//        titleLabel.text = viewModel.title
//        createdAtLabel.text = viewModel.createdAt.timeAgoDisplay()
//        bodyLabel.text = viewModel.body
//        titleLabel.text = viewModel.notification.repository.fullName
//        unreadImageView.isHidden = !viewModel.notification.unread
    }
}
