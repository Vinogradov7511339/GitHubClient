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
}

final class RepositoryFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
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

    func folderViewController() -> UIViewController {
        UIViewController()
    }

    func fileViewController() -> UIViewController {
        UIViewController()
    }

    func issuesViewController() -> UIViewController {
        UIViewController()
    }

    func issueViewController() -> UIViewController {
        UIViewController()
    }

    func pullRequestsViewController() -> UIViewController {
        UIViewController()
    }

    func pullRequestViewController() -> UIViewController {
        UIViewController()
    }

    func releasesViewController() -> UIViewController {
        UIViewController()
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
