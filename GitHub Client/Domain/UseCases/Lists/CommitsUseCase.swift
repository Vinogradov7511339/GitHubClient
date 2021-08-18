//
//  CommitsUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol CommitsUseCase {
    typealias CommitsHandler = (Result<CommitsResponseModel, Error>) -> Void

    func fetch(request: CommitsRequestModel, completion: @escaping CommitsHandler)
}

final class CommitsUseCaseImpl {

    private let repository: RepRepository

    init(repository: RepRepository) {
        self.repository = repository
    }
}

// MARK: - CommitsUseCase
extension CommitsUseCaseImpl: CommitsUseCase {
    func fetch(request: CommitsRequestModel, completion: @escaping CommitsHandler) {
        repository.fetchCommits(request: request, completion: completion)
    }
}
