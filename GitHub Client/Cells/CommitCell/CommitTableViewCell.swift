//
//  CommitTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

struct CommitCellViewModel {
    let authorsAvatars: [URL?]
    let message: String
    let additionalMessage: String?
    let authoredBy: NSAttributedString
    let isVerified: Bool?
    let date: String
}

class CommitTableViewCell: BaseTableViewCell, NibLoadable {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorAvatarImageView: WebImageView!
    @IBOutlet weak var additionalMessageLabel: UILabel!
    @IBOutlet weak var authorsStackView: UIStackView!
    @IBOutlet weak var authoredByLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension CommitTableViewCell: ConfigurableCell {
    func configure(viewModel: CommitCellViewModel) {
        messageLabel.text = viewModel.message
        dateLabel.text = viewModel.date

        if let isVerified = viewModel.isVerified {
            statusImageView.isHidden = false
            updateStatusIcon(isVerified: isVerified)
        } else {
            statusImageView.isHidden = true
        }

        if let additionalMessage = viewModel.additionalMessage {
            additionalMessageLabel.isHidden = false
            additionalMessageLabel.text = additionalMessage
        } else {
            additionalMessageLabel.isHidden = true
        }

        if viewModel.authorsAvatars.count == 1 {
            authorAvatarImageView.set(url: viewModel.authorsAvatars[0])
        } else {
            //todo
        }
    }
    
    private func updateStatusIcon(isVerified: Bool) {
        let statusImageName = isVerified ? "checkmark" : "xmark"
        let templateColor: UIColor = isVerified ? .systemGreen : .systemRed
        let image = UIImage(systemName: statusImageName)?.withTintColor(templateColor, renderingMode: .alwaysOriginal)
        statusImageView.image = image
    }
}
