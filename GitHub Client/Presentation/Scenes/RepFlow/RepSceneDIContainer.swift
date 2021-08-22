//
//  RepSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class RepSceneDIContainer {

    struct Dependencies {
        let repository: Repository
        var showUser: (User) -> Void
        var showRepository: (Repository) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
        var copy: (String) -> Void
    }

    private let dependencies: Dependencies
    private let repositoryFactory: RepositoryFactory

    init(parentContainer: MainSceneDIContainer, dependencies: Dependencies) {
        self.dependencies = dependencies
        repositoryFactory = RepositoryFactoryImpl(dataTransferService: parentContainer.apiDataTransferService)
    }

    func makeRepFlowCoordinator(in navigationController: UINavigationController) -> RepFlowCoordinator {
        return .init(navigationController: navigationController, dependencies: self)
    }
}

extension RepSceneDIContainer: RepFlowCoordinatorDependencies {
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

    func folderViewController() -> UIViewController {
        repositoryFactory.folderViewController()
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

    func show(user: User) {
        dependencies.showUser(user)
    }

    func show(repository: Repository) {
        dependencies.showRepository(repository)
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
