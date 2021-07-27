//
//  IssueDetailsCommentTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

struct IssueCommentCellViewModel {
    let avatarUrl: URL?
    let userName: String
    let userStatus: String
    let message: NSAttributedString
    let reactImages: [UIImage]
}

class IssueDetailsCommentTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var avatarImageView: WebImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userStatusLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var reactImagesStackView: UIStackView!
    
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

extension IssueDetailsCommentTableViewCell: ConfigurableCell {
    func configure(viewModel: IssueCommentCellViewModel) {
        avatarImageView.set(url: viewModel.avatarUrl)
        userNameLabel.text = viewModel.userName
        if viewModel.userStatus == "OWNER" {
            configureOwnerBadge()
        }
        messageLabel.attributedText = viewModel.message
        //images
    }
    
    private func configureOwnerBadge() {
        userStatusLabel.text = "Owner"
    }
}
