//
//  SettingsDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class SettingsDIContainer {

    struct Dependencies {
        var logout: () -> Void
    }

    private let settingsFactory: SettingsFactory
    var logout: () -> Void

    init(_ dependencies: Dependencies) {
        settingsFactory = SettingsFactoryImpl()
        self.logout = dependencies.logout
    }
}

// MARK: - SettingsCoordinatorDependencies
extension SettingsDIContainer: SettingsCoordinatorDependencies {
    func settingsViewController(_ actions: SettingsActions) -> UIViewController {
        settingsFactory.settingsViewController(actions)
    }

    func accountViewController(_ actions: AccountActions) -> UIViewController {
        settingsFactory.accountViewController(actions)
    }
}
