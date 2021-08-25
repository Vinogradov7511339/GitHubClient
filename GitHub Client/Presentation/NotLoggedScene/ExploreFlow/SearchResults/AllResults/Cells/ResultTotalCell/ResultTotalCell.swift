//
//  ResultTotalCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

struct ResultTotalViewModel {
    let type: SearchType
    let totalCount: Int
}

class ResultTotalCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var totalResultsLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension ResultTotalCell: ConfigurableCell {

    func configure(viewModel: ResultTotalViewModel) {
        let formattedTotal = viewModel.totalCount.separatedBy(".")

        switch viewModel.type {
        case .repositories:
            totalResultsLabel.text = "See all \(formattedTotal) repositories"
        case .issues:
            totalResultsLabel.text = "See all \(formattedTotal) issues"
        case .pullRequests:
            totalResultsLabel.text = "See all \(formattedTotal) pull requests"
        case .people:
            totalResultsLabel.text = "See all \(formattedTotal) people"
        }
    }
}
