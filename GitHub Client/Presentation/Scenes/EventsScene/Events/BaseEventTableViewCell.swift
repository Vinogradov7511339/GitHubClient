//
//  BaseEventTableViewCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

struct BaseEventCellViewModel {
    let eventType: String
}

class BaseEventTableViewCell: BaseTableViewCell, NibLoadable {

    @IBOutlet weak var eventTypeLabel: UILabel!

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension BaseEventTableViewCell: ConfigurableCell {
    func configure(viewModel: BaseEventCellViewModel) {
        eventTypeLabel.text = viewModel.eventType
    }
}
