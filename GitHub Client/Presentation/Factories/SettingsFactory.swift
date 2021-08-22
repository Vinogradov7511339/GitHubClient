//
//  SettingsFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol SettingsFactory {
    func settingsViewController(_ actions: SettingsActions) -> UIViewController
    func accountViewController(_ actions: AccountActions) -> UIViewController
}

final class SettingsFactoryImpl {}

// MARK: - SettingsFactory
extension SettingsFactoryImpl: SettingsFactory {
    func settingsViewController(_ actions: SettingsActions) -> UIViewController {
        SettingsViewController.create(with: settingsViewModel(actions))
    }

    func accountViewController(_ actions: AccountActions) -> UIViewController {
        AccountViewController.create(with: accountViewModel(actions))
    }
}

// MARK: - Private
private extension SettingsFactoryImpl {
    func settingsViewModel(_ actions: SettingsActions) -> SettingsViewModel {
        SettingsViewModelImpl(actions: actions)
    }

    func accountViewModel(_ actions: AccountActions) -> AccountViewModel {
        AccountViewModelImpl(actions)
    }
}
