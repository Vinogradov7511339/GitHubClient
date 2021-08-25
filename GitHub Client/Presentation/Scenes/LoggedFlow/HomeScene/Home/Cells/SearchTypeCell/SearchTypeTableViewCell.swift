//
//  SearchTypeTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

struct SearchTypeCellViewModel {
    let image: UIImage?
    let baseText: String
    var text: String = ""

    init(_ type: SearchType) {
        switch type {
        case .repositories:
            image = UIImage.issue
            baseText = "Repositories with "
        case .issues:
            image = UIImage.issue
            baseText = "Issues with "
        case .pullRequests:
            image = UIImage.pullRequest
            baseText = "Pull Requests with "
        case .people:
            image = UIImage.issue
            baseText = "People with "
        }
    }
}

class SearchTypeTableViewCell: BaseTableViewCell, NibLoadable {

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        self.configure(viewModel: viewModel)
    }
}

extension SearchTypeTableViewCell: ConfigurableCell {
    func configure(viewModel: SearchTypeCellViewModel) {
        imageView?.image = viewModel.image
        textLabel?.text = viewModel.text
    }
}
