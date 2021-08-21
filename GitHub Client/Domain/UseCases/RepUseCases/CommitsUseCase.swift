//
//  CommitsUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol CommitUseCase {
    typealias CommitsHandler = RepRepository.CommitsHandler
    func fetchCommits(request: CommitsRequestModel, completion: @escaping CommitsHandler)

    typealias CommitHandler = RepRepository.CommitHandler
    func fetchCommit(request: CommitRequestModel, completion: @escaping CommitHandler)

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
    func fetchCommits(request: CommitsRequestModel, completion: @escaping CommitsHandler) {
        repRepository.fetchCommits(request: request, completion: completion)
    }

    func fetchCommit(request: CommitRequestModel, completion: @escaping CommitHandler) {
        repRepository.fetchCommit(request: request, completion: completion)
    }

    func fetchComments(_ request: CommentsRequestModel<Commit>, completion: @escaping CommentsHandler) {
        repRepository.fetchCommitComments(request: request, completion: completion)
    }
}
