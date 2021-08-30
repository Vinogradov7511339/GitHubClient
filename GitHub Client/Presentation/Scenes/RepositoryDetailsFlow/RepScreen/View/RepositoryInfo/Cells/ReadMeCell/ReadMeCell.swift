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
    func configure(viewModel: RepositoryDetails) {
        guard stackView.arrangedSubviews.isEmpty else {
            return
        }
        guard let text = viewModel.mdText else { return }
        let renderer = MDRenderer(text: text)
        renderer.render(in: stackView)
    }
}
