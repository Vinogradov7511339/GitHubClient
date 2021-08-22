//
//  CodeOptionCell.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

class CodeOptionCellViewModel {

    enum SettingsType {
        case showLineNumbers(CodeOptions)
        case forceDarkMode(CodeOptions)
        case lineWrapping(CodeOptions)
    }

    let optionName: String
    let switchState: Observable<Bool>

    init(type: SettingsType) {
        switch type {
        case .showLineNumbers(let settings):
            optionName = "Show Line Numbers"
            switchState = settings.showLineNumbers
        case .forceDarkMode(let settings):
            optionName = "Force Dark Mode"
            switchState = settings.forceDarkMode
        case .lineWrapping(let settings):
            optionName = "Line Wrapping"
            switchState = settings.lineWrapping
        }
    }
}

class CodeOptionCell: BaseTableViewCell, NibLoadable {

    weak var viewModel: CodeOptionCellViewModel?

    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!

    @IBAction func optonSwitchValueChanged(_ sender: UISwitch) {
        viewModel?.switchState.value = sender.isOn
    }

    override func populate(viewModel: Any) {
        super.populate(viewModel: viewModel)
        configure(viewModel: viewModel)
    }
}

// MARK: - ConfigurableCell
extension CodeOptionCell: ConfigurableCell {
    func configure(viewModel: CodeOptionCellViewModel) {
        optionSwitch.isOn = viewModel.switchState.value
        optionNameLabel.text = viewModel.optionName
        self.viewModel = viewModel
    }
}
