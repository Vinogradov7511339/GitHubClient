//
//  CommitsDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

final class CommitsDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let issueFilterStorage: IssueFilterStorage
        let commitsUrl: URL

        let showCommit: (URL, UINavigationController) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let repFactory: RepositoryFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.repFactory = RepositoryFactoryImpl(
            dataTransferService: dependencies.dataTransferService,
            issueFilterStorage: dependencies.issueFilterStorage)
    }
}

// MARK: - CommitsCoordinatorDependencies
extension CommitsDIContainer: CommitsCoordinatorDependencies {
    func commitsViewController(actions: CommitsActions) -> UIViewController {
        repFactory.commitsViewController(dependencies.commitsUrl, actions: actions)
    }

    func show(_ commit: URL, in nav: UINavigationController) {
        dependencies.showCommit(commit, nav)
    }
}
