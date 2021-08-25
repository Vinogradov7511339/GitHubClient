//
//  IssueHeaderCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

class IssueHeaderCell: BaseCollectionViewCell, NibLoadable {

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusBGView: UIView!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bodyStackView: UIStackView!
    
    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension IssueHeaderCell: ConfigurableCell {
    func configure(viewModel: Issue) {
        userAvatarImageView.set(url: viewModel.user.avatarUrl)
        userLoginLabel.text = viewModel.user.login
        titleLabel.text = viewModel.title

        let bodyLabel = UILabel()
        bodyStackView.addArrangedSubview(bodyLabel)
        bodyLabel.text = viewModel.body
    }
}
