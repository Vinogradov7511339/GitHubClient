//
//  HomeDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

final class HomeDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let profileStorage: ProfileLocalStorage
        let issueFilterStorage: IssueFilterStorage

        let showIssue: (Issue, UINavigationController) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let homeSceneFactory: HomeSceneFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.homeSceneFactory = HomeSceneFactoryImpl(
            dataTransferService: dependencies.dataTransferService,
            profileStorage: dependencies.profileStorage,
            issueFilerStorage: dependencies.issueFilterStorage)
    }
}

// MARK: - HomeFlowCoordinatorDependencies
extension HomeDIContainer: HomeFlowCoordinatorDependencies {
    func homeViewController(_ actions: HomeActions) -> UIViewController {
        homeSceneFactory.homeViewController(actions)
    }

    func myIssuesViewController(_ actions: MyIssuesActions) -> UIViewController {
        homeSceneFactory.myIssuesViewController(actions)
    }

    func openIssue(_ issue: Issue, nav: UINavigationController) {
        dependencies.showIssue(issue, nav)
    }
}
