//
//  IssueDetailsHeaderTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

struct IssueHeaderCellViewModel {
    let avatarUrl: URL?
    let repositoryName: String
    let title: String
    let stateImage: UIImage?
}

class IssueDetailsHeaderTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusBadge: StatusBadgeView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func actionButtonTouchUpInside(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

extension IssueDetailsHeaderTableViewCell: ConfigurableCell {
    func configure(viewModel: IssueHeaderCellViewModel) {
        avatarImageView.set(url: viewModel.avatarUrl)
        repositoryNameLabel.text = viewModel.repositoryName
        titleLabel.text = viewModel.title
        statusBadge.configure(status: .openIssue)
    }
}
