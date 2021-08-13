//
//  RepositoriesFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol RepositoriesFactory {
    func makeMyRepositoriesViewController(actions: RepositoriesActions) -> RepositoriesViewController
    func makeMyStarredViewController(actions: RepositoriesActions) -> RepositoriesViewController

    func createRepositoriesViewController(for user: User, actions: RepositoriesActions) -> RepositoriesViewController
    func createStarrredViewController(for user: User, actions: RepositoriesActions) -> RepositoriesViewController

    func createForksViewController(for repository: Repository, actions: RepositoriesActions) -> RepositoriesViewController
}

final class RepositoriesFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - RepositoriesFactory
extension RepositoriesFactoryImpl: RepositoriesFactory {
    func makeMyRepositoriesViewController(actions: RepositoriesActions) -> RepositoriesViewController {
        .create(with: createMyRepositoriesViewModel(actions: actions))
    }

    func makeMyStarredViewController(actions: RepositoriesActions) -> RepositoriesViewController {
        .create(with: createMyStarredViewModel(actions: actions))
    }

    func createRepositoriesViewController(for user: User, actions: RepositoriesActions) -> RepositoriesViewController {
        .create(with: createRepositoriesViewModel(for: user, actions: actions))
    }

    func createStarrredViewController(for user: User, actions: RepositoriesActions) -> RepositoriesViewController {
        .create(with: createStarredViewModel(for: user, actions: actions))
    }

    func createForksViewController(for repository: Repository, actions: RepositoriesActions) -> RepositoriesViewController {
        .create(with: createForksViewModel(for: repository, actions: actions))
    }
}

private extension RepositoriesFactoryImpl {
    func createMyRepositoriesViewModel(actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl.init(useCase: createRepositoriesUseCase(), type: .myRepositories, actions: actions)
    }

    func createMyStarredViewModel(actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl.init(useCase: createRepositoriesUseCase(), type: .myStarred, actions: actions)
    }

    func createRepositoriesViewModel(for user: User, actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl.init(useCase: createRepositoriesUseCase(), type: .userRepositories(user), actions: actions)
    }

    func createStarredViewModel(for user: User, actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl.init(useCase: createRepositoriesUseCase(), type: .userStarred(user), actions: actions)
    }

    func createForksViewModel(for repository: Repository, actions: RepositoriesActions) -> RepositoriesViewModel {
        RepositoriesViewModelImpl.init(useCase: createRepositoriesUseCase(), type: .forks(repository), actions: actions)
    }

    func createRepositoriesUseCase() -> RepositoriesUseCase {
        return RepositoriesUseCaseImpl(repository: createRepositoriesRepository())
    }

    func createRepositoriesRepository() -> RepositoriesRepository {
        return RepositoriesRepositoryImpl(dataTransferService: dataTransferService)
    }
}
