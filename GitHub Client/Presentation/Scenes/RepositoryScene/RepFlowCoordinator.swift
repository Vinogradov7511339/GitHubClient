//
//  RepFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

protocol RepFlowCoordinatorDependencies {
    func makeRepViewController(actions: RepActions) -> UIViewController
    func makeStargazersViewController(for repository: Repository, actions: UsersListActions) -> UsersListViewController
    func makeForksViewController(for repository: Repository, actions: RepositoriesActions) -> RepositoriesViewController
    func makeIssuesViewController(for repository: Repository, actions: IssuesActions) -> IssuesViewController
    func makePullRequestsViewController(for repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest>
    func makeReleasesViewController(for repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewController<Release>
    func makeCommitsViewController(for repository: Repository, actions: CommitsActions) -> CommitsViewController
    func makeIssueViewController(for issue: Issue, actions: IssueActions) -> IssueDetailsViewController
    func makeContentViewCoontroller(path: URL, actions: FolderActions) -> UIViewController
    func makeFileViewController(path: URL, actions: FileActions) -> UIViewController
    func makeCodeOptionsViwController() -> UIViewController
    func makeBranchesViewController(repository: Repository, actions: BranchesActions) -> UIViewController
    func startUserFlow(with user: User)
    func startRepFlow(with repository: Repository)
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
        let actions = actions()
        let viewController = dependencies.makeRepViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RepFlowCoordinator {
    func actions() -> RepActions {
        .init(
            showBranches: showBranches(_:),
            showStargazers: showStargazers(_:),
            showForks: showForks(_:),
            showOwner: dependencies.startUserFlow(with:),
            showIssues: showIssues(_:),
            showPullRequests: showPullRequests(_:),
            showReleases: showReleases(_:),
            showWatchers: showWatchers(_:),
            showCode: showCode(_:),
            showCommits: showCommits(_:),
            openLink: dependencies.openLink(url:),
            share: dependencies.share(url:)
        )
    }

    func showBranches(_ repository: Repository) {
        let actions = BranchesActions(select: didSelectBranch(_:))
        let viewController = dependencies.makeBranchesViewController(repository: repository, actions: actions)
        let nav = UINavigationController(rootViewController: viewController)
        navigationController?.viewControllers.last?.present(nav, animated: true, completion: nil)
    }

    func didSelectBranch(_ branch: Branch) {}

    func showStargazers(_ repository: Repository) {
        let actions = UsersListActions(showUser: dependencies.startUserFlow(with:))
        let viewController = dependencies.makeStargazersViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showForks(_ repository: Repository) {
        let actions = RepositoriesActions(showRepository: dependencies.startRepFlow(with:))
        let viewController = dependencies.makeForksViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showIssues(_ repository: Repository) {
        let actions = IssuesActions(showIssue: startIssueFlow(_:))
        let viewController = dependencies.makeIssuesViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showPullRequests(_ repository: Repository) {
        let actions = ItemsListActions(showDetails: startPullRequestFlow(_:))
        let viewController = dependencies.makePullRequestsViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showReleases(_ repository: Repository) {
        let actions = ItemsListActions(showDetails: startReleaseFlow(_:))
        let viewController = dependencies.makeReleasesViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showWatchers(_ repository: Repository) {}

    func showCode(_ path: URL) {
        let actions = FolderActions(openFolder: showCode(_:),
                                    openFile: openFile(_:),
                                    openFolderSettings: openFoldersSettings,
                                    share: dependencies.share(url:),
                                    copy: dependencies.copy(text:))
        let viewController = dependencies.makeContentViewCoontroller(path: path, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func openFile(_ filePath: URL) {
        let actions = FileActions(openCodeOptions: openCodeOptions,
                                  copy: dependencies.copy,
                                  share: dependencies.share(url:))
        let viewController = dependencies.makeFileViewController(path: filePath, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showCommits(_ repository: Repository) {
        let actions = CommitsActions(showCommit: startCommitsFlow(_:))
        let viewController = dependencies.makeCommitsViewController(for: repository, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension RepFlowCoordinator {

    func startIssueFlow(_ issue: Issue) {
        let actions = IssueActions()
        let viewController = dependencies.makeIssueViewController(for: issue, actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func startCommitsFlow(_ commit: ExtendedCommit) {}
    func startReleaseFlow(_ release: Release) {}
    func startPullRequestFlow(_ pullRequest: PullRequest) {}

    func openCodeOptions() {
        let viewController = dependencies.makeCodeOptionsViwController()
        let nav = UINavigationController(rootViewController: viewController)
        navigationController?.viewControllers.last?.present(nav, animated: true, completion: nil)
    }

    func openFoldersSettings() {}
}
