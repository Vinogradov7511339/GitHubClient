//
//  ExtendedRepositoryFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import UIKit

protocol ExtendedRepositoryFactory {
    func makeExtendedRepositoryViewController(actions: RepActions) -> UIViewController
}

final class ExtendedRepositoryFactoryImpl {

    private let repository: Repository
    private let favoriteStorage: FavoritesStorage
    private let dataTransferService: DataTransferService

    init(repository: Repository, favoriteStorage: FavoritesStorage, dataTransferService: DataTransferService) {
        self.repository = repository
        self.favoriteStorage = favoriteStorage
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ExtendedRepositoryFactory
extension ExtendedRepositoryFactoryImpl: ExtendedRepositoryFactory {
    func makeExtendedRepositoryViewController(actions: RepActions) -> UIViewController {
        RepViewController.create(with: makeRepViewModel(actions: actions))
    }
}

// MARK: - Private
private extension ExtendedRepositoryFactoryImpl {
    func makeRepViewModel(actions: RepActions) -> RepViewModel {
        return RepViewModelImpl(repository: repository, repUseCase: makeRepUseCase(), actions: actions)
    }

    func makeRepUseCase() -> RepUseCase {
        return RepUseCaseImpl(favoritesStorage: favoriteStorage, repositoryStorage: makeRepRepository())
    }

    func makeRepRepository() -> RepRepository {
        return RepRepositoryImpl(dataTransferService: dataTransferService)
    }
}
