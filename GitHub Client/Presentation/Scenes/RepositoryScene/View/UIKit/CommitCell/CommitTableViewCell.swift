//
//  CommitTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit


//    func map(_ commit: CommitInfoResponse) -> CommitCellViewModel {
//        let components = commit.commit.message.components(separatedBy: "\n\n")
//        let message: String
//        let additionMessage: String?
//        if components.count > 1 {
//            message = components[0]
//            additionMessage = components[1]
//        } else if !components.isEmpty {
//            message = components[0]
//            additionMessage = nil
//        } else {
//            message = ""
//            additionMessage = nil
//        }
//
//        return CommitCellViewModel(
//            authorsAvatars: [commit.author.avatarUrl], //todo
//            message: message,
//            additionalMessage: additionMessage,
//            authoredBy: NSAttributedString(string: "NaN"),
//            isVerified: commit.commit.verification.verified,
//            date: "NaN"
//        )
//    }

struct CommitCellViewModel {
    let authorsAvatars: [URL?]
    let message: String
    let additionalMessage: String?
    let authoredBy: NSAttributedString
    let isVerified: Bool?
    let date: String

    init(_ commit: Commit) {
        authorsAvatars = [commit.author.avatarUrl]
        message = commit.message
        additionalMessage = nil
        authoredBy = NSAttributedString(string: "Todo")
        isVerified = false
        date = "ToDo"
    }
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
    func configure(viewModel: Commit) {
        messageLabel.text = viewModel.message
//        messageLabel.text = viewModel.message
//        dateLabel.text = viewModel.date
//
//        if let isVerified = viewModel.isVerified {
//            statusImageView.isHidden = false
//            updateStatusIcon(isVerified: isVerified)
//        } else {
//            statusImageView.isHidden = true
//        }
//
//        if let additionalMessage = viewModel.additionalMessage {
//            additionalMessageLabel.isHidden = false
//            additionalMessageLabel.text = additionalMessage
//        } else {
//            additionalMessageLabel.isHidden = true
//        }
//
//        if viewModel.authorsAvatars.count == 1 {
//            authorAvatarImageView.set(url: viewModel.authorsAvatars[0])
//        } else {
//            //todo
//        }
    }
    
    private func updateStatusIcon(isVerified: Bool) {
        let statusImageName = isVerified ? "checkmark" : "xmark"
        let templateColor: UIColor = isVerified ? .systemGreen : .systemRed
        let image = UIImage(systemName: statusImageName)?.withTintColor(templateColor, renderingMode: .alwaysOriginal)
        statusImageView.image = image
    }
}
