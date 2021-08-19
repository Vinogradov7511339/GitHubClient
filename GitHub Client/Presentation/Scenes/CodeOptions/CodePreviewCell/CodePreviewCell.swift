//
//  CodePreviewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

struct CodeOptions {
    let lineWrapping: Bool
}

struct CodePreviewCellViewModel {
    let codeOptions: CodeOptions
    let code: String
}

class CodePreviewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CodePreviewCell: ConfigurableCell {
    func configure(viewModel: CodePreviewCellViewModel) {
        let lineWrapping = viewModel.codeOptions.lineWrapping
        contentLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -16.0).isActive = lineWrapping
        layoutIfNeeded()
        contentLabel.text = viewModel.code
    }
}
