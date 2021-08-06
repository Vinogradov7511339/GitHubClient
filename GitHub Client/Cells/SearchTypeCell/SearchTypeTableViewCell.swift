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
