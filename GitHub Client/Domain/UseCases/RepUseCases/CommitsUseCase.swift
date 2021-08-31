//
//  CommitsUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol CommitUseCase {
    typealias CommitHandler = RepRepository.CommitHandler
    func fetchCommit(commitUrl: URL, completion: @escaping CommitHandler)

    typealias CommentsHandler = RepRepository.CommentsHandler
    func fetchComments(_ request: CommentsRequestModel<Commit>, completion: @escaping CommentsHandler)
}

final class CommitUseCaseImpl {

    private let repRepository: RepRepository

    init(repRepository: RepRepository) {
        self.repRepository = repRepository
    }
}

// MARK: - CommitsUseCase
extension CommitUseCaseImpl: CommitUseCase {
    func fetchCommit(commitUrl: URL, completion: @escaping CommitHandler) {
        repRepository.fetchCommit(commitUrl, completion: completion)
    }

    func fetchComments(_ request: CommentsRequestModel<Commit>, completion: @escaping CommentsHandler) {
        repRepository.fetchCommitComments(request: request, completion: completion)
    }
}
