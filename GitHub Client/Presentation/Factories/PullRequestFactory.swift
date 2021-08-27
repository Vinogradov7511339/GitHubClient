//
//  PullRequestFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol PullRequestFactory {
    func pullRequestViewController() -> UIViewController
}

final class PullRequestFactoryImpl {
}

// MARK: - PullRequestFactory
extension PullRequestFactoryImpl: PullRequestFactory {
    func pullRequestViewController() -> UIViewController {
        UIViewController()
    }
}
