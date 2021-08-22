//
//  ExploreTempUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

protocol ExploreTempUseCase {
    typealias RepositoriesHandler = ExploreTempRepository.RepositoriesHandler
    func fetch(_ searchModel: SearchRequestModel, completion: @escaping RepositoriesHandler)
}

final class ExploreTempUseCaseImpl {

    private let exploreRepository: ExploreTempRepository

    init(exploreRepository: ExploreTempRepository) {
        self.exploreRepository = exploreRepository
    }
}

// MARK: - ExploreTempUseCase
extension ExploreTempUseCaseImpl: ExploreTempUseCase {
    func fetch(_ searchModel: SearchRequestModel, completion: @escaping RepositoriesHandler) {
        exploreRepository.fetch(searchModel, completion: completion)
    }
}
