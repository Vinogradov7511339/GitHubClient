//
//  HomeUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

protocol HomeUseCase {
    func fetchWidgets(completion: @escaping(Result<[HomeWidget], Error>) -> Void)
}

final class HomeUseCaseImpl {

    let repository: MyProfileRepository
    let favoritesStorage: FavoritesStorage

    init(repository: MyProfileRepository, favoritesStorage: FavoritesStorage) {
        self.repository = repository
        self.favoritesStorage = favoritesStorage
    }
}

// MARK: - HomeUseCase
extension HomeUseCaseImpl: HomeUseCase {
    func fetchWidgets(completion: @escaping (Result<[HomeWidget], Error>) -> Void) {
        favoritesStorage.fetchWidgets(completion: completion)
    }
}
