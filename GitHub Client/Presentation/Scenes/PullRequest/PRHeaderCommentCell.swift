//
//  PRHeaderCommentCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

class PRHeaderCommentCell: BaseTableViewCell, NibLoadable {

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
    }
}

// MARK: - Configure
extension PRHeaderCommentCell: ConfigurableCell {
    func configure(viewModel: PullRequestDetails) {
    }
}
