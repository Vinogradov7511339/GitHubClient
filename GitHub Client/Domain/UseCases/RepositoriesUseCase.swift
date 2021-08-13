//
//  RepositoriesUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

enum RepositoriesType {
    case myRepositories
    case myStarred

    case userRepositories(User)
    case userStarred(User)

    case forks(Repository)
}

struct RepositoriesRequestModel {
    let page: Int
    let listType: RepositoriesType
}

struct RepositoriesResponseModel {
    let items: [Repository]
    let lastPage: Int
}

protocol RepositoriesUseCase {
    func fetch(request: RepositoriesRequestModel,
               completion: @escaping (Result<RepositoriesResponseModel, Error>) -> Void)
}

final class RepositoriesUseCaseImpl {

    let repository: RepositoriesRepository

    init(repository: RepositoriesRepository) {
        self.repository = repository
    }
}

// MARK: - RepositoriesUseCase
extension RepositoriesUseCaseImpl: RepositoriesUseCase {
    func fetch(request: RepositoriesRequestModel, completion: @escaping (Result<RepositoriesResponseModel, Error>) -> Void) {
        repository.fetch(requestModel: request, completion: completion)
    }
}
