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
        repositoryFactory = RepositoryFactoryImpl(dataTransferService: dependencies.dataTransferService)
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

    func issuesViewController() -> UIViewController {
        repositoryFactory.issuesViewController()
    }

    func issueViewController() -> UIViewController {
        repositoryFactory.issueViewController()
    }

    func pullRequestsViewController() -> UIViewController {
        repositoryFactory.pullRequestsViewController()
    }

    func pullRequestViewController() -> UIViewController {
        repositoryFactory.pullRequestViewController()
    }

    func releasesViewController() -> UIViewController {
        repositoryFactory.releasesViewController()
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
