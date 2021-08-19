//
//  CodeOptionCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

class CodeOptionCellViewModel {
    let optionName: String
    let switchState: Bool
    let switchHandler: (Bool) -> Void

    internal init(optionName: String, switchState: Bool, switchHandler: @escaping (Bool) -> Void) {
        self.optionName = optionName
        self.switchState = switchState
        self.switchHandler = switchHandler
    }
}

class CodeOptionCell: BaseTableViewCell, NibLoadable {

    weak var viewModel: CodeOptionCellViewModel?

    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!

    @IBAction func optonSwitchValueChanged(_ sender: UISwitch) {
        viewModel?.switchHandler(sender.isOn)
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CodeOptionCell: ConfigurableCell {
    func configure(viewModel: CodeOptionCellViewModel) {
        optionSwitch.isOn = viewModel.switchState
        optionNameLabel.text = viewModel.optionName
        self.viewModel = viewModel
    }
}
