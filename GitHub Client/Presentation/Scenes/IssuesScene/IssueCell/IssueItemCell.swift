//
//  IssueItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 16.08.2021.
//

import UIKit

class IssueItemCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var openedByLabel: UILabel!
    @IBOutlet weak var openedAtLabel: UILabel!
    @IBOutlet weak var issueStateLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension IssueItemCell: ConfigurableCell {
    func configure(viewModel: Issue) {
        issueTitleLabel.text = viewModel.title
        openedByLabel.attributedText = attributedText(issue: viewModel)
        openedAtLabel.text = viewModel.openedAt.timeAgoDisplay()
        issueStateLabel.text = viewModel.state
        commentsCountLabel.text = "\(viewModel.commentsCount)"
    }

    func attributedText(issue: Issue) -> NSAttributedString {
        let number = NSAttributedString(string: "#\(issue.number) ")
        let openedByStr = NSLocalizedString("opened by ", comment: "")
        let openedBy = NSAttributedString(string: openedByStr, attributes: [.foregroundColor: UIColor.secondaryLabel])
        let author = NSAttributedString(string: issue.user.login)

        let fullString = NSMutableAttributedString()
        fullString.append(number)
        fullString.append(openedBy)
        fullString.append(author)
        return fullString
    }
}
