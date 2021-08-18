//
//  RepositoriesUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol RepositoriesUseCase {
    typealias RepositoriesHandler = (Result<RepositoriesResponseModel, Error>) -> Void

    func fetch(request: RepositoriesRequestModel, completion: @escaping RepositoriesHandler)
}

final class RepositoriesUseCaseImpl {

    private let repository: RepositoriesRepository

    init(repository: RepositoriesRepository) {
        self.repository = repository
    }
}

// MARK: - RepositoriesUseCase
extension RepositoriesUseCaseImpl: RepositoriesUseCase {
    func fetch(request: RepositoriesRequestModel, completion: @escaping RepositoriesHandler) {
        repository.fetch(requestModel: request, completion: completion)
    }
}
