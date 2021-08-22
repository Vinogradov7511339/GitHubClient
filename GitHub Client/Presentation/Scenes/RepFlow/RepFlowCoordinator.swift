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
    func commitsViewController(_ actions: CommitsActions) -> UIViewController
    func commitViewController() -> UIViewController
    func folderViewController() -> UIViewController
    func fileViewController() -> UIViewController
    func issuesViewController() -> UIViewController
    func issueViewController() -> UIViewController
    func pullRequestsViewController() -> UIViewController
    func pullRequestViewController() -> UIViewController
    func releasesViewController() -> UIViewController
    func releaseViewController() -> UIViewController
    func licenseViewController() -> UIViewController
    func watchersViewController() -> UIViewController
    func forksViewController() -> UIViewController

    func codeOptionsViewController() -> UIViewController
    func show(user: User)
    func show(repository: Repository)
    func openLink(url: URL)
    func share(url: URL)
    func copy(text: String)
}

final class RepFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: RepFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController, dependencies: RepFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = dependencies.repositoryViewController(actions: actions())
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RepFlowCoordinator {
    func actions() -> RepActions {
        .init(
            showBranches: showBranches,
            showStargazers: showStargazers(_:),
            showForks: showForks(_:),
            showOwner: dependencies.show(user:),
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
        let actions = IssuesActions(showIssue: startIssueFlow(_:))
        let viewController = dependencies.issuesViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showPullRequests(_ repository: Repository) {
        let actions = PRListActions(show: startPullRequestFlow(_:))
        let viewController = dependencies.pullRequestsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showReleases(_ repository: Repository) {
        let actions = ReleasesActions(show: startReleaseFlow(_:))
        let viewController = dependencies.releasesViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showWatchers(_ repository: Repository) {}

    func showCode(_ path: URL) {
        let actions = FolderActions(openFolder: showCode(_:),
                                    openFile: openFile(_:),
                                    openFolderSettings: openFoldersSettings,
                                    share: dependencies.share(url:),
                                    copy: dependencies.copy(text:))
        let viewController = dependencies.folderViewController()
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
        let viewController = dependencies.commitsViewController(actions  )
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension RepFlowCoordinator {

    func startIssueFlow(_ issue: Issue) {
        let actions = IssueActions()
        let viewController = dependencies.issuesViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func startCommitsFlow(_ commit: ExtendedCommit) {}
    func startReleaseFlow(_ release: Release) {}
    func startPullRequestFlow(_ pullRequest: PullRequest) {}

    func openCodeOptions() {
        let viewController = dependencies.codeOptionsViewController()
        let nav = UINavigationController(rootViewController: viewController)
        navigationController?.viewControllers.last?.present(nav, animated: true, completion: nil)
    }

    func openFoldersSettings() {}
}
