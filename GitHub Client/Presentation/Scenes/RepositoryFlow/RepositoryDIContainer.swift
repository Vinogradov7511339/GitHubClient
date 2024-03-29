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
        let url: URL

        var showUser: (URL, UINavigationController) -> Void
        var showIssue: (URL, UINavigationController) -> Void
        var showPullRequest: (PullRequest, UINavigationController) -> Void
        var showRelease: (Release, UINavigationController) -> Void
        let showCommits: (URL, UINavigationController) -> Void
        var showRepository: (URL, UINavigationController) -> Void

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
        repositoryFactory.repositoryViewController(dependencies.url, actions: actions)
    }

    func branchesViewController() -> UIViewController {
        repositoryFactory.branchesViewController()
    }

    func showCommits(_ url: URL, in nav: UINavigationController) {
        dependencies.showCommits(url, nav)
    }

    func folderViewController(_ folder: FolderItem, actions: FolderActions) -> UIViewController {
        repositoryFactory.folderViewController(folder, actions: actions)
    }

    func fileViewController(_ path: URL, actions: FileActions) -> UIViewController {
        repositoryFactory.fileViewController(path, actions: actions)
    }

    func issuesViewController(_ url: URL, actions: IssuesActions) -> UIViewController {
        repositoryFactory.issuesViewController(url, actions: actions)
    }

    func pullRequestsViewController(_ url: URL, actions: PRListActions) -> UIViewController {
        repositoryFactory.pullRequestsViewController(url, actions: actions)
    }

    func releasesViewController(_ url: URL, actions: ReleasesActions) -> UIViewController {
        repositoryFactory.releasesViewController(url, actions: actions)
    }

    func licenseViewController() -> UIViewController {
        repositoryFactory.licenseViewController()
    }

    func usersViewController(_ type: RepositoryUsersType, actions: UsersActions) -> UIViewController {
        repositoryFactory.usersViewController(type, actions: actions)
    }

    func forksViewController(_ url: URL, actions: RepositoriesActions) -> UIViewController {
        repositoryFactory.forksViewController(url, actions: actions)
    }

    // MARK: - Dependencies

    func codeOptionsViewController() -> UIViewController {
        fatalError()
    }

    func showIssue(_ issue: Issue, in nav: UINavigationController) {
        dependencies.showIssue(issue.url, nav)
    }

    func showRepository(_ rep: URL, in nav: UINavigationController) {
        dependencies.showRepository(rep, nav)
    }

    func showPullRequest(_ pr: PullRequest, in nav: UINavigationController) {
        dependencies.showPullRequest(pr, nav)
    }

    func showRelease(_ release: Release, in nav: UINavigationController) {
        dependencies.showRelease(release, nav)
    }

    func showUser(_ url: URL, in nav: UINavigationController) {
        dependencies.showUser(url, nav)
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
