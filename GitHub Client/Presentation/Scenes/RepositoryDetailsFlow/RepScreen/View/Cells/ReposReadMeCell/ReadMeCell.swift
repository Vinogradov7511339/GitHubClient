//
//  ReadMeCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit

class ReadMeCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var stackView: UIStackView!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ReadMeCell: ConfigurableCell {
    func configure(viewModel: String) {
        guard stackView.arrangedSubviews.isEmpty else {
            return
        }
        let renderer = MDRenderer(text: viewModel)
        renderer.render(in: stackView)
    }
}
