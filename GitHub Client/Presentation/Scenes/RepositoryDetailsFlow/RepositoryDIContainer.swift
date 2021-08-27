//
//  RepSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class RepositoryDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let issueFilterStorage: IssueFilterStorage
        let repository: Repository

        var showUser: (User, UINavigationController) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
        var copy: (String) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let repositoryFactory: RepositoryFactory

    // MARK: - Lifecycle

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        repositoryFactory = RepositoryFactoryImpl(
            dataTransferService: dependencies.dataTransferService,
            issueFilterStorage: dependencies.issueFilterStorage)
    }
}

// MARK: - Routing
extension RepositoryDIContainer: RepFlowCoordinatorDependencies {
    func repositoryViewController(actions: RepActions) -> UIViewController {
        repositoryFactory.repositoryViewController(dependencies.repository, actions: actions)
    }

    func branchesViewController() -> UIViewController {
        repositoryFactory.branchesViewController()
    }

    func commitsViewController(_ actions: CommitsActions) -> UIViewController {
        repositoryFactory.commitsViewController(dependencies.repository, actions: actions)
    }

    func commitViewController() -> UIViewController {
        repositoryFactory.commitViewController()
    }

    func folderViewController(_ path: URL, actions: FolderActions) -> UIViewController {
        repositoryFactory.folderViewController(path, actions: actions)
    }

    func fileViewController() -> UIViewController {
        repositoryFactory.fileViewController()
    }

    func issuesViewController(_ repository: Repository, actions: IssuesActions) -> UIViewController {
        repositoryFactory.issuesViewController(repository, actions: actions)
    }

    func issueViewController() -> UIViewController {
        repositoryFactory.issueViewController()
    }

    func pullRequestsViewController(_ rep: Repository, actions: PRListActions) -> UIViewController {
        repositoryFactory.pullRequestsViewController(rep, actions: actions)
    }

    func pullRequestViewController() -> UIViewController {
        repositoryFactory.pullRequestViewController()
    }

    func releasesViewController(_ rep: Repository, actions: ReleasesActions) -> UIViewController {
        repositoryFactory.releasesViewController(rep, actions: actions)
    }

    func releaseViewController() -> UIViewController {
        repositoryFactory.releaseViewController()
    }

    func licenseViewController() -> UIViewController {
        repositoryFactory.licenseViewController()
    }

    func watchersViewController() -> UIViewController {
        repositoryFactory.watchersViewController()
    }

    func forksViewController() -> UIViewController {
        repositoryFactory.forksViewController()
    }

    func codeOptionsViewController() -> UIViewController {
        fatalError()
    }

    func show(user: User, in nav: UINavigationController) {
        dependencies.showUser(user, nav)
    }

    func openLink(url: URL) {
        dependencies.openLink(url)
    }

    func share(url: URL) {
        dependencies.share(url)
    }

    func copy(text: String) {
        dependencies.copy(text)
    }
}
