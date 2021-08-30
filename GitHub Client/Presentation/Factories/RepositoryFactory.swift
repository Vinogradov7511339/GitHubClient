//
//  RepositoryFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

protocol RepositoryFactory {
    func repositoryViewController(_ rep: Repository, actions: RepActions) -> UIViewController
    func branchesViewController() -> UIViewController
    func commitsViewController(_ commitsUrl: URL, actions: CommitsActions) -> UIViewController
    func commitViewController(_ commitUrl: URL, actions: CommitActions) -> UIViewController
    func folderViewController(_ path: URL, actions: FolderActions) -> UIViewController
    func fileViewController() -> UIViewController
    func issuesViewController(_ url: URL, actions: IssuesActions) -> UIViewController
    func pullRequestsViewController(_ url: URL, actions: PRListActions) -> UIViewController
    func releasesViewController(_ url: URL, actions: ReleasesActions) -> UIViewController
    func licenseViewController() -> UIViewController
    func watchersViewController() -> UIViewController
    func forksViewController(_ url: URL, actions: ForksActions) -> UIViewController
}

final class RepositoryFactoryImpl {

    private let dataTransferService: DataTransferService
    private let issueFilterStorage: IssueFilterStorage

    init(dataTransferService: DataTransferService,
         issueFilterStorage: IssueFilterStorage) {

        self.dataTransferService = dataTransferService
        self.issueFilterStorage = issueFilterStorage
    }
}

// MARK: - RepositoryFactory
extension RepositoryFactoryImpl: RepositoryFactory {
    func repositoryViewController(_ rep: Repository, actions: RepActions) -> UIViewController {
        RepViewController.create(with: repViewModel(rep, actions: actions))
    }

    func branchesViewController() -> UIViewController {
        UIViewController()
    }

    func commitsViewController(_ commitsUrl: URL, actions: CommitsActions) -> UIViewController {
        CommitsViewController.create(with: commitsViewModel(commitsUrl, actions: actions))
    }

    func commitViewController(_ commitUrl: URL, actions: CommitActions) -> UIViewController {
        CommitViewController.create(with: commitViewModel(commitUrl, actions: actions))
    }

    func folderViewController(_ path: URL, actions: FolderActions) -> UIViewController {
        FolderViewController.create(with: folderViewModel(path, actions: actions))
    }

    func fileViewController() -> UIViewController {
        UIViewController()
    }

    func issuesViewController(_ url: URL, actions: IssuesActions) -> UIViewController {
        IssuesViewController.create(with: issuesViewModel(url, actions: actions))
    }

    func pullRequestsViewController(_ url: URL, actions: PRListActions) -> UIViewController {
        PRListViewController.create(with: prListViewModel(url, actions: actions))
    }

    func releasesViewController(_ url: URL, actions: ReleasesActions) -> UIViewController {
        ReleasesViewController.create(with: releasesViewModel(url, actions: actions))
    }

    func releaseViewController() -> UIViewController {
        UIViewController()
    }

    func licenseViewController() -> UIViewController {
        UIViewController()
    }

    func watchersViewController() -> UIViewController {
        UIViewController()
    }

    func forksViewController(_ url: URL, actions: ForksActions) -> UIViewController {
        ForksViewController.create(with: forksViewModel(url, actions: actions))
    }
}

// MARK: - Private
private extension RepositoryFactoryImpl {
    func repViewModel(_ rep: Repository, actions: RepActions) -> RepViewModel {
        RepViewModelImpl(repository: rep, repUseCase: repUseCase, actions: actions)
    }

    func commitsViewModel(_ commitsUrl: URL, actions: CommitsActions) -> CommitsViewModel {
        CommitsViewModelImpl(commitUseCase: commitsUseCase, commitsUrl: commitsUrl, actions: actions)
    }

    func commitViewModel(_ commitUrl: URL, actions: CommitActions) -> CommitViewModel {
        CommitViewModelImpl(commitUrl: commitUrl, useCase: commitsUseCase, actions: actions)
    }

    func folderViewModel(_ path: URL, actions: FolderActions) -> FolderViewModel {
        FolderViewModelImpl(actions: actions, path: path, repUseCase: repUseCase)
    }

    func issuesViewModel(_ url: URL, actions: IssuesActions) -> IssuesViewModel {
        IssuesViewModelImpl(url, issueUseCase: issueUseCase, actions: actions)
    }

    func prListViewModel(_ url: URL, actions: PRListActions) -> PRListViewModel {
        PRListViewModelImpl(url, useCase: pullRequestUseCase, actions: actions)
    }

    func releasesViewModel(_ url: URL, actions: ReleasesActions) -> ReleasesViewModel {
        ReleasesViewModelImpl(url, useCase: repUseCase, actions: actions)
    }

    func forksViewModel(_ url: URL, actions: ForksActions) -> ForksViewModel {
        ForksViewModelImpl(url, useCase: repUseCase, actions: actions)
    }

    var issueUseCase: IssueUseCase {
        IssueUseCaseImpl(repRepository: repRepository, filterStorage: issueFilterStorage)
    }

    var pullRequestUseCase: PRUseCase {
        PRUseCaseImpl(repRepository: repRepository)
    }

    var repUseCase: RepUseCase {
        RepUseCaseImpl(repositoryStorage: repRepository, repositoryFacade: repFacade)
    }

    var repFacade: RepositoryFacade {
        RepositoryFacadeImpl(repRepository: repRepository)
    }

    var commitsUseCase: CommitUseCase {
        CommitUseCaseImpl(repRepository: repRepository)
    }

    var repRepository: RepRepository {
        RepRepositoryImpl(dataTransferService: dataTransferService)
    }
}
