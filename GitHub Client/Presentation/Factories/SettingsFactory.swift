//
//  SettingsFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol SettingsFactory {
    func settingsViewController() -> UIViewController
}

final class SettingsFactoryImpl {}

// MARK: - SettingsFactory
extension SettingsFactoryImpl: SettingsFactory {
    func settingsViewController() -> UIViewController {
        SettingsViewController.create(with: settingsViewModel())
    }
}

// MARK: - Private
private extension SettingsFactoryImpl {
    func settingsViewModel() -> SettingsViewModel {
        SettingsViewModelImpl()
    }
}
