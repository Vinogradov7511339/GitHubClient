//
//  CommitDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

final class CommitDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let issueFilterStorage: IssueFilterStorage
        let commitUrl: URL
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

// MARK: - CommitCoordinatorDependencies
extension CommitDIContainer: CommitCoordinatorDependencies {
    func commitViewController(_ actions: CommitActions) -> UIViewController {
        repFactory.commitViewController(dependencies.commitUrl, actions: actions)
    }
}
