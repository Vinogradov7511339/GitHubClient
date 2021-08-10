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
}

class RepUseCaseImpl {

    let favoritesStorage: FavoritesStorage

    init(favoritesStorage: FavoritesStorage) {
        self.favoritesStorage = favoritesStorage
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
}
