//
//  FavoritesFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

protocol FavoritesFactory {
    func makeFavoritesViewController() -> FavoritesViewController
}

final class FavoritesFactoryImpl {

    private let apiDataTransferService: DataTransferService
    private let favoritesStorage: FavoritesStorage

    init(apiDataTransferService: DataTransferService, favoritesStorage: FavoritesStorage) {
        self.apiDataTransferService = apiDataTransferService
        self.favoritesStorage = favoritesStorage
    }
}

// MARK: - FavoritesFactory
extension FavoritesFactoryImpl: FavoritesFactory {
    func makeFavoritesViewController() -> FavoritesViewController {
        .create(with: makeFavoritesViewModel())
    }
}

private extension FavoritesFactoryImpl {
    func makeFavoritesViewModel() -> FavoritesViewModel {
        FavoritesViewModelImpl(useCase: makeFavoritesUseCase())
    }

    func makeFavoritesUseCase() -> FavoritesUseCase {
        FavoritesUseCaseImpl(repository: makeHomeRepository(), favoritesStorage: favoritesStorage)
    }

    func makeHomeRepository() -> HomeRepository {
        HomeRepositoryImpl(dataTransferService: apiDataTransferService)
    }
}
