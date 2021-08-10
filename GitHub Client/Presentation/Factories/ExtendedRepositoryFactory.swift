//
//  ExtendedRepositoryFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

protocol ExtendedRepositoryFactory {
    func makeExtendedRepositoryViewController(actions: RepActions) -> RepViewController
}

final class ExtendedRepositoryFactoryImpl {

    private let repository: Repository
    private let favoriteStorage: FavoritesStorage

    init(repository: Repository, favoriteStorage: FavoritesStorage) {
        self.repository = repository
        self.favoriteStorage = favoriteStorage
    }
}

// MARK: - ExtendedRepositoryFactory
extension ExtendedRepositoryFactoryImpl: ExtendedRepositoryFactory {
    func makeExtendedRepositoryViewController(actions: RepActions) -> RepViewController {
        .create(with: makeRepViewModel(actions: actions))
    }
}

// MARK: - Private
private extension ExtendedRepositoryFactoryImpl {
    func makeRepViewModel(actions: RepActions) -> RepViewModel {
        return RepViewModelImpl(repository: repository, repUseCase: makeRepUseCase(), actions: actions)
    }

    func makeRepUseCase() -> RepUseCase {
        return RepUseCaseImpl(favoritesStorage: favoriteStorage)
    }

    func makeRepRepository() -> RepRepository {
        return RepRepositoryImpl()
    }
}
