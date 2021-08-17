//
//  RepUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepUseCase {
    func addFavorite(repository: Repository, completion: @escaping (Error?) -> Void)
    func removeFavorite(by repositoryId: Int, completion: @escaping (Error?) -> Void)
    func fetch(repository: Repository, completion: @escaping (Result<String, Error>) -> Void)
}

class RepUseCaseImpl {

    let favoritesStorage: FavoritesStorage
    let repositoryStorage: RepRepository

    init(favoritesStorage: FavoritesStorage, repositoryStorage: RepRepository) {
        self.favoritesStorage = favoritesStorage
        self.repositoryStorage = repositoryStorage
    }
}

// MARK: - RepUseCase
extension RepUseCaseImpl: RepUseCase {
    func addFavorite(repository: Repository, completion: @escaping (Error?) -> Void) {
        favoritesStorage.addFavorite(repository: repository, completion: completion)
    }

    func removeFavorite(by repositoryId: Int, completion: @escaping (Error?) -> Void) {
        favoritesStorage.removeFavorite(by: repositoryId, completion: completion)
    }

    func fetch(repository: Repository, completion: @escaping (Result<String, Error>) -> Void) {
        repositoryStorage.fetchReadMe(repository: repository, completion: completion)
    }
}
