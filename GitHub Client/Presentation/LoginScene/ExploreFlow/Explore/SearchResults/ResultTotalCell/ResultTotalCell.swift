//
//  ResultTotalCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

struct ResultTotalViewModel {
    enum ResultType {
        case repList
        case issues
        case users
    }

    let type: ResultType
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
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        let total = NSNumber(integerLiteral: viewModel.totalCount)
        let formattedTotal = formater.string(from: total) ?? "\(total)"

        switch viewModel.type {
        case .repList:
            totalResultsLabel.text = "See \(formattedTotal) more repositories"
        case .issues:
            totalResultsLabel.text = "See \(formattedTotal) more issues"
        case .users:
            totalResultsLabel.text = "See \(formattedTotal) more users"
        }
    }
}
