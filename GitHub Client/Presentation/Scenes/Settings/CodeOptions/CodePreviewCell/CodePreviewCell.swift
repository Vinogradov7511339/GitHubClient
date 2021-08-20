//
//  CodePreviewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

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
        let lineWrapping = viewModel.codeOptions.lineWrapping.value
        let existingConstraint = contentLabel.constraints.filter { $0.firstAttribute == .width }.first
        if let existingConstraint = existingConstraint, lineWrapping {
            existingConstraint.constant = bounds.width - 16.0
        } else {
            contentLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -16.0).isActive = lineWrapping
        }

        let darkMode = viewModel.codeOptions.forceDarkMode.value
        overrideUserInterfaceStyle = darkMode ? .dark : .light

        contentLabel.text = viewModel.code
    }
}
