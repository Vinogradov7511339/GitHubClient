//
//  MyProfileActivityItemCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.09.2021.
//

import UIKit

protocol MyProfileActivityItemCellDelegate: AnyObject {
    func linkTapped(_ url: URL)
}

class MyProfileActivityItemCell: BaseCollectionViewCell, NibLoadable {

    // MARK: - Delegate

    weak var delegate: MyProfileActivityItemCellDelegate?

    // MARK: - Views

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!

    // MARK: - Lifecycle

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension MyProfileActivityItemCell: ConfigurableCell {
    func configure(viewModel: Event) {
        eventImageView.image = viewModel.image
        createdAtLabel.text = viewModel.createdAt.timeAgoDisplay()
        titleTextView.textContainerInset = UIEdgeInsets.zero
        titleTextView.textContainer.lineFragmentPadding = 0
        titleTextView.attributedText = viewModel.fullTitle
        titleTextView.delegate = self
    }
}

// MARK: - UITextViewDelegate
extension MyProfileActivityItemCell: UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        delegate?.linkTapped(URL)
        return false
    }
}
