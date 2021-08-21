//
//  PRListUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

protocol PRUseCase {
    typealias PRListHandler = RepRepository.PRListHandler
    func fetchPRList(request: PRListRequestModel, completion: @escaping PRListHandler)

    typealias PRHandler = RepRepository.PRHandler
    func fetchPR(request: PRRequestModel, completion: @escaping PRHandler)

    typealias CommentsHandler = RepRepository.CommentsHandler
    func fetchComments(_ request: CommentsRequestModel<PullRequest>, completion: @escaping CommentsHandler)
}

final class PRUseCaseImpl {

    private let repRepository: RepRepository

    init(repRepository: RepRepository) {
        self.repRepository = repRepository
    }
}

// MARK: - PRUseCase
extension PRUseCaseImpl: PRUseCase {
    func fetchPRList(request: PRListRequestModel, completion: @escaping PRListHandler) {
        repRepository.fetchPRList(request: request, completion: completion)
    }

    func fetchPR(request: PRRequestModel, completion: @escaping PRHandler) {
        repRepository.fetchPR(request: request, completion: completion)
    }

    func fetchComments(_ request: CommentsRequestModel<PullRequest>, completion: @escaping CommentsHandler) {
        repRepository.fetchPullRequestComments(request: request, completion: completion)
    }
}
