//
//  ReleaseFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol ReleaseFactory {
    func releaseViewController() -> UIViewController
}

final class ReleaseFactoryImpl {}

// MARK: - ReleaseFactory
extension ReleaseFactoryImpl: ReleaseFactory {
    func releaseViewController() -> UIViewController {
        UIViewController()
    }
}
