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
        var showIssue: (Issue, UINavigationController) -> Void
        var showPullRequest: (PullRequest, UINavigationController) -> Void
        var showRelease: (Release, UINavigationController) -> Void

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

    // MARK: - Factory

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

    func pullRequestsViewController(_ rep: Repository, actions: PRListActions) -> UIViewController {
        repositoryFactory.pullRequestsViewController(rep, actions: actions)
    }

    func releasesViewController(_ rep: Repository, actions: ReleasesActions) -> UIViewController {
        repositoryFactory.releasesViewController(rep, actions: actions)
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

    // MARK: - Dependencies

    func codeOptionsViewController() -> UIViewController {
        fatalError()
    }

    func showIssue(_ issue: Issue, in nav: UINavigationController) {
        dependencies.showIssue(issue, nav)
    }

    func showPullRequest(_ pr: PullRequest, in nav: UINavigationController) {
        dependencies.showPullRequest(pr, nav)
    }

    func showRelease(_ release: Release, in nav: UINavigationController) {
        dependencies.showRelease(release, nav)
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
