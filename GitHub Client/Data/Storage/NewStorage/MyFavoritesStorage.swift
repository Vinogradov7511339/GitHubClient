//
//  MyFavoritesStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

protocol MyFavoritesStorage {
    func fetchFavorites(completion: @escaping (Result<[Repository], Error>) -> Void)
}

final class MyFavoritesStorageImpl {}

// MARK: - MyFavoritesStorage
extension MyFavoritesStorageImpl: MyFavoritesStorage {
    func fetchFavorites (completion: @escaping (Result<[Repository], Error>) -> Void) {
        completion(.success([]))
    }
}
