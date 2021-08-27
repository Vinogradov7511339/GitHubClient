//
//  PullRequestDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

final class PullRequestDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let pullRequest: PullRequest
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let prFactory: PullRequestFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.prFactory = PullRequestFactoryImpl()
    }
}

// MARK: - PullRequestCoordinatorDependencies
extension PullRequestDIContainer: PullRequestCoordinatorDependencies {
    func prViewController() -> UIViewController {
        prFactory.pullRequestViewController()
    }
}
