//
//  HomeRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

final class HomeRepositoryImpl {

    private let dataTransferService: DataTransferService
    private let favoritesStorage: MyFavoritesStorage

    init(dataTransferService: DataTransferService, favoritesStorage: MyFavoritesStorage) {
        self.dataTransferService = dataTransferService
        self.favoritesStorage = favoritesStorage
    }
}

// MARK: - HomeRepository
extension HomeRepositoryImpl: HomeRepository {
    func fetchRecent(completion: @escaping (Result<[Issue], Error>) -> Void) {

    }
}
