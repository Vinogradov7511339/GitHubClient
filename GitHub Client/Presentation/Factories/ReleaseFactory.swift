//
//  ReleaseFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol ReleaseFactory {
    func releaseViewController(_ release: Release, actions: ReleaseActions) -> UIViewController
}

final class ReleaseFactoryImpl {}

// MARK: - ReleaseFactory
extension ReleaseFactoryImpl: ReleaseFactory {
    func releaseViewController(_ release: Release, actions: ReleaseActions) -> UIViewController {
        ReleaseViewController.create(with: releaseViewModel(release, actions: actions))
    }
}

// MARK: - Private
private extension ReleaseFactoryImpl {
    func releaseViewModel(_ release: Release, actions: ReleaseActions) -> ReleaseViewModel {
        ReleaseViewModelImpl(release, actions: actions)
    }
}
