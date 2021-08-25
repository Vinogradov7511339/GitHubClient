//
//  SettingsDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class SettingsDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        var logout: () -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let settingsFactory: SettingsFactory

    // MARK: - Lifecycle

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        settingsFactory = SettingsFactoryImpl()
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

    func logout() {
        dependencies.logout()
    }
}
