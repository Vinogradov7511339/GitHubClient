//
//  IssueTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

//struct IssueCellViewModel {
//    let image: UIImage?
//    let repositoryName: String
//    let name: String
//    let date: String
//    let bottomImage: UIImage?
//}

class IssueTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension IssueTableViewCell: ConfigurableCell {
    func configure(viewModel: Any) {
        if let issue = viewModel as? Issue {
            configure(issue: issue)
        } else if let pullRequest = viewModel as? PullRequest {
            configure(pullRequest: pullRequest)
        } else if let dicussion = viewModel as? Discussion {
            configure(discussion: dicussion)
        }
    }
    
    private func configure(issue: Issue) {
        itemImageView.image = UIImage.issue
        nameLabel.text = issue.title ?? ""
    }
    
    private func configure(pullRequest: PullRequest) {
        itemImageView.image = UIImage.pullRequest
        nameLabel.text = pullRequest.title ?? ""
    }
    
    private func configure(discussion: Discussion) {
        itemImageView.image = UIImage.discussions
        nameLabel.text = discussion.title ?? ""
    }
}
