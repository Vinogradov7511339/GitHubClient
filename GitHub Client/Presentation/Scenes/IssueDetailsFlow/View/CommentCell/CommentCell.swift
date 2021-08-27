//
//  CommentCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.08.2021.
//

import UIKit

protocol CommentCellDelegate: AnyObject {}

class CommentCell: BaseCollectionViewCell, NibLoadable {

    // MARK: - Delegate

    weak var delegate: CommentCellDelegate?

    // MARK: - Views

    @IBOutlet weak var userAvatarImageView: WebImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var messageStackView: UIStackView!
    @IBOutlet weak var emotionsStackView: UIStackView!

    // MARK: - Actions

    @IBAction func addEmotionButtonTouchUpInside(_ sender: UIButton) {
        
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CommentCell: ConfigurableCell {
    func configure(viewModel: Comment) {
        userAvatarImageView.set(url: viewModel.user.avatarUrl)
        userLoginLabel.text = viewModel.user.login

        let bodyLabel = UILabel()
        bodyLabel.numberOfLines = 0
        messageStackView.addArrangedSubview(bodyLabel)
        bodyLabel.text = viewModel.body
    }
}
