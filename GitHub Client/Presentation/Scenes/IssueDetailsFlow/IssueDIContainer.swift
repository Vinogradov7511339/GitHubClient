//
//  IssueDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

final class IssueDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let filterStorage: IssueFilterStorage
        let issue: Issue
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let issueFactory: IssueFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.issueFactory = IssueFactoryImpl(
            dataTrasferService: dependencies.dataTransferService,
            filterStorage: dependencies.filterStorage)
    }
}

// MARK: - IssueCoordinatorDependencies
extension IssueDIContainer: IssueCoordinatorDependencies {
    func issueViewController(actions: IssueActions) -> UIViewController {
        issueFactory.issueViewController(dependencies.issue, actions: actions)
    }
}
