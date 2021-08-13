//
//  CommitsUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

struct CommitsRequestModel {
    let page: Int
    let repository: Repository
}

struct CommitsResponseModel {
    let items: [Commit]
    let lastPage: Int
}

protocol CommitsUseCase {
    func fetch(request: CommitsRequestModel,
               completion: @escaping (Result<CommitsResponseModel, Error>) -> Void)
}

final class CommitsUseCaseImpl {

    let repository: RepRepository

    init(repository: RepRepository) {
        self.repository = repository
    }
}

// MARK: - CommitsUseCase
extension CommitsUseCaseImpl: CommitsUseCase {
    func fetch(request: CommitsRequestModel, completion: @escaping (Result<CommitsResponseModel, Error>) -> Void) {
        repository.fetchCommits(request: request, completion: completion)
    }
}
