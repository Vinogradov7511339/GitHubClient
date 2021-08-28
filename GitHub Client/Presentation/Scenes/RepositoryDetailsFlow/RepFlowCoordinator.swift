//
//  RepFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol RepFlowCoordinatorDependencies {
    func repositoryViewController(actions: RepActions) -> UIViewController
    func branchesViewController() -> UIViewController
    func commitsViewController(actions: CommitsActions) -> UIViewController
    func commitViewController() -> UIViewController
    func folderViewController(_ path: URL, actions: FolderActions) -> UIViewController
    func fileViewController() -> UIViewController
    func issuesViewController(_ repository: Repository, actions: IssuesActions) -> UIViewController
    func pullRequestsViewController(_ rep: Repository, actions: PRListActions) -> UIViewController
    func releasesViewController(_ rep: Repository, actions: ReleasesActions) -> UIViewController
    func licenseViewController() -> UIViewController
    func watchersViewController() -> UIViewController
    func forksViewController() -> UIViewController

    func showPullRequest(_ pr: PullRequest, in nav: UINavigationController)
    func showRelease(_ release: Release, in nav: UINavigationController)
    func showIssue(_ issue: Issue, in nav: UINavigationController)

    func codeOptionsViewController() -> UIViewController
    func show(user: User, in nav: UINavigationController)
    func openLink(url: URL)
    func share(url: URL)
    func copy(text: String)
}

final class RepFlowCoordinator {

    // MARK: - Private variables

    private weak var navigationController: UINavigationController?
    private let dependencies: RepFlowCoordinatorDependencies

    // MARK: - Lifecycle

    init(in navigationController: UINavigationController, with dependencies: RepFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        guard let nav = navigationController else { return }
        let viewController = dependencies.repositoryViewController(actions: actions(nav))
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Repository Actions
private extension RepFlowCoordinator {
    func actions(_ nav: UINavigationController) -> RepActions {
        .init(
            showBranches: showBranches,
            showStargazers: showStargazers(_:),
            showForks: showForks(_:),
            showOwner: showUser(in: nav),
            showIssues: showIssues(_:),
            showPullRequests: showPullRequests(_:),
            showReleases: showReleases(_:),
            showWatchers: showWatchers(_:),
            showCode: showCode(_:),
            showCommits: showCommits,
            openLink: dependencies.openLink(url:),
            share: dependencies.share(url:)
        )
    }
}

// MARK: - Routing
private extension RepFlowCoordinator {
    func showUser(in nav: UINavigationController) -> (User) -> Void {
        return { user in self.dependencies.show(user: user, in: nav)}
    }

    func showBranches(_ repository: Repository, _ action: @escaping (Branch) -> Void) {
        let actions = BranchesActions(select: action)
        let viewController = dependencies.branchesViewController()
        let nav = UINavigationController(rootViewController: viewController)
        navigationController?.viewControllers.last?.present(nav, animated: true, completion: nil)
    }

    func showStargazers(_ repository: Repository) {
//        let actions = UsersListActions(showUser: dependencies.show(user:))
//        let viewController = dependencies.makeStargazersViewController(for: repository, actions: actions)
//        navigationController?.pushViewController(viewController, animated: true)
    }

    func showForks(_ repository: Repository) {
        let viewController = dependencies.forksViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showIssues(_ repository: Repository) {
        guard let nav = navigationController else { return }
        let actions = IssuesActions(showIssue: showIssue(in: nav))
        let viewController = dependencies.issuesViewController(repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showPullRequests(_ repository: Repository) {
        guard let nav = navigationController else { return }
        let actions = PRListActions(show: showPullRequest(in: nav))
        let viewController = dependencies.pullRequestsViewController(repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showReleases(_ repository: Repository) {
        guard let nav = navigationController else { return }
        let actions = ReleasesActions(show: showRelease(in: nav))
        let viewController = dependencies.releasesViewController(repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showWatchers(_ repository: Repository) {}

    func showCode(_ path: URL) {
        let actions = FolderActions(openFolder: showCode(_:),
                                    openFile: openFile(_:),
                                    openFolderSettings: openFoldersSettings,
                                    share: dependencies.share(url:),
                                    copy: dependencies.copy(text:))
        let viewController = dependencies.folderViewController(path, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func openFile(_ filePath: URL) {
        let actions = FileActions(openCodeOptions: openCodeOptions,
                                  copy: dependencies.copy,
                                  share: dependencies.share(url:))
        let viewController = dependencies.fileViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showCommits(_ repository: Repository, _ branch: String) {
        let actions = CommitsActions(showCommit: startCommitsFlow(_:))
        let viewController = dependencies.commitsViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension RepFlowCoordinator {

    func showIssue(in nav: UINavigationController) -> (Issue) -> Void {
        return { issue in self.dependencies.showIssue(issue, in: nav)}
    }

    func showPullRequest(in nav: UINavigationController) -> (PullRequest) -> Void {
        return { pr in self.dependencies.showPullRequest(pr, in: nav) }
    }

    func showRelease(in nav: UINavigationController) -> (Release) -> Void {
        return { release in self.dependencies.showRelease(release, in: nav) }
    }

    func startCommitsFlow(_ commit: ExtendedCommit) {}

    func openCodeOptions() {
        let viewController = dependencies.codeOptionsViewController()
        let nav = UINavigationController(rootViewController: viewController)
        navigationController?.viewControllers.last?.present(nav, animated: true, completion: nil)
    }

    func openFoldersSettings() {}
}
