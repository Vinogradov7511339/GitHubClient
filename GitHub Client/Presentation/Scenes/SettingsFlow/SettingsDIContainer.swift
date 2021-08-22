//
//  SettingsDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class SettingsDIContainer {

    private let settingsFactory: SettingsFactory

    init() {
        settingsFactory = SettingsFactoryImpl()
    }
}

// MARK: - SettingsCoordinatorDependencies
extension SettingsDIContainer: SettingsCoordinatorDependencies {
    func settingsViewController() -> UIViewController {
        settingsFactory.settingsViewController()
    }
}
