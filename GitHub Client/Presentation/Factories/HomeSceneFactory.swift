//
//  HomeSceneFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//
protocol HomeSceneFactory {
    func makeHomeViewController(_ actions: HomeActions) -> HomeViewController
}

final class HomeSceneFactoryImpl {
    private let dataTransferService: DataTransferService
    private let storage: FavoritesStorage

    init(dataTransferService: DataTransferService, storage: FavoritesStorage) {
        self.dataTransferService = dataTransferService
        self.storage = storage
    }
}

// MAK: - HomeSceneFactory
extension HomeSceneFactoryImpl: HomeSceneFactory {
    func makeHomeViewController(_ actions: HomeActions) -> HomeViewController {
        .create(with: createHomeViewModel(actions: actions))
    }
}

private extension HomeSceneFactoryImpl {
    func createHomeViewModel(actions: HomeActions) -> HomeViewModel {
        HomeViewModelImpl(useCase: createHomeUseCase(), actions: actions)
    }

    func createHomeUseCase() -> HomeUseCase {
        HomeUseCaseImpl(repository: createHomeRepository(), favoritesStorage: storage)
    }

    func createHomeRepository() -> HomeRepository {
        HomeRepositoryImpl(dataTransferService: dataTransferService)
    }
}
