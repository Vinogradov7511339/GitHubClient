//
//  CommitsFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol CommitsFactory {
    func makeCommitsViewController(repository: Repository, actions: CommitsActions) -> CommitsViewController
}

final class CommitsFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - CommitsFactory
extension CommitsFactoryImpl: CommitsFactory {
    func makeCommitsViewController(repository: Repository, actions: CommitsActions) -> CommitsViewController {
        .create(with: createCommitsViewModel(repository: repository, actions: actions))
    }
}

private extension CommitsFactoryImpl {
    func createCommitsViewModel(repository: Repository, actions: CommitsActions) -> CommitsViewModel {
        CommitsViewModelImpl.init(useCase: createCommitsUseCase(), repository: repository, actions: actions)
    }

    func createCommitsUseCase() -> CommitsUseCase {
        return CommitsUseCaseImpl(repository: createCommitsRepository())
    }

    func createCommitsRepository() -> RepRepository {
        return RepRepositoryImpl(dataTransferService: dataTransferService)
    }
}
