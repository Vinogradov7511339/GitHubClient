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
        self.prFactory = PullRequestFactoryImpl(dataTransferService: dependencies.dataTransferService)
    }
}

// MARK: - PullRequestCoordinatorDependencies
extension PullRequestDIContainer: PullRequestCoordinatorDependencies {
    func prViewController(actions: PRActions) -> UIViewController {
        prFactory.pullRequestViewController(dependencies.pullRequest, actions: actions)
    }
}
