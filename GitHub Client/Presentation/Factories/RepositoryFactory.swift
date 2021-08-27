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
    func commitsViewController(_ rep: Repository, actions: CommitsActions) -> UIViewController
    func commitViewController() -> UIViewController
    func folderViewController(_ path: URL, actions: FolderActions) -> UIViewController
    func fileViewController() -> UIViewController
    func issuesViewController(_ repository: Repository, actions: IssuesActions) -> UIViewController
    func issueViewController() -> UIViewController
    func pullRequestsViewController(_ rep: Repository, actions: PRListActions) -> UIViewController
    func pullRequestViewController() -> UIViewController
    func releasesViewController(_ rep: Repository, actions: ReleasesActions) -> UIViewController
    func releaseViewController() -> UIViewController
    func licenseViewController() -> UIViewController
    func watchersViewController() -> UIViewController
    func forksViewController() -> UIViewController
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

    func commitsViewController(_ rep: Repository, actions: CommitsActions) -> UIViewController {
        CommitsViewController.create(with: commitsViewModel(rep, actions: actions))
    }

    func commitViewController() -> UIViewController {
        UIViewController()
    }

    func folderViewController(_ path: URL, actions: FolderActions) -> UIViewController {
        FolderViewController.create(with: folderViewModel(path, actions: actions))
    }

    func fileViewController() -> UIViewController {
        UIViewController()
    }

    func issuesViewController(_ repository: Repository, actions: IssuesActions) -> UIViewController {
        IssuesViewController.create(with: issuesViewModel(repository, actions: actions))
    }

    func issueViewController() -> UIViewController {
        UIViewController()
    }

    func pullRequestsViewController(_ rep: Repository, actions: PRListActions) -> UIViewController {
        PRListViewController.create(with: prListViewModel(rep, actions: actions))
    }

    func pullRequestViewController() -> UIViewController {
        UIViewController()
    }

    func releasesViewController(_ rep: Repository, actions: ReleasesActions) -> UIViewController {
        ReleasesViewController.create(with: releasesViewModel(rep, actions: actions))
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

    func forksViewController() -> UIViewController {
        UIViewController()
    }
}

// MARK: - Private
private extension RepositoryFactoryImpl {
    func repViewModel(_ rep: Repository, actions: RepActions) -> RepViewModel {
        RepViewModelImpl(repository: rep, repUseCase: repUseCase, actions: actions)
    }

    func commitsViewModel(_ rep: Repository, actions: CommitsActions) -> CommitsViewModel {
        CommitsViewModelImpl(commitUseCase: commitsUseCase, repository: rep, actions: actions)
    }

    func folderViewModel(_ path: URL, actions: FolderActions) -> FolderViewModel {
        FolderViewModelImpl(actions: actions, path: path, repUseCase: repUseCase)
    }

    func issuesViewModel(_ repository: Repository, actions: IssuesActions) -> IssuesViewModel {
        IssuesViewModelImpl(issueUseCase: issueUseCase, repository: repository, actions: actions)
    }

    func prListViewModel(_ rep: Repository, actions: PRListActions) -> PRListViewModel {
        PRListViewModelImpl(rep: rep, useCase: pullRequestUseCase, actions: actions)
    }

    func releasesViewModel(_ rep: Repository, actions: ReleasesActions) -> ReleasesViewModel {
        ReleasesViewModelImpl(rep: rep, useCase: repUseCase, actions: actions)
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
