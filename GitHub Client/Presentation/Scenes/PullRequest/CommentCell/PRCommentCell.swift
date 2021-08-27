//
//  PRCommentCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol PRCommentCellDelegate: AnyObject {}

class PRCommentCell: BaseTableViewCell, NibLoadable {

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension PRCommentCell: ConfigurableCell {
    func configure(viewModel: Comment) {
    }
}
