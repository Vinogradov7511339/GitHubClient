//
//  PRListUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

protocol PRUseCase {
    typealias PRListHandler = RepRepository.PRListHandler
    func fetchPRList(_ url: URL, page: Int, completion: @escaping PRListHandler)

    typealias PRHandler = RepRepository.PRHandler
    func fetchPR(_ pullRequest: PullRequest, completion: @escaping PRHandler)

    typealias CommentsHandler = RepRepository.CommentsHandler
    func fetchComments(_ request: CommentsRequestModel<PullRequest>, completion: @escaping CommentsHandler)

    func fetchDiff(_ url: URL, completion: @escaping (Result<String, Error>) -> Void)
}

final class PRUseCaseImpl {

    private let repRepository: RepRepository

    init(repRepository: RepRepository) {
        self.repRepository = repRepository
    }
}

// MARK: - PRUseCase
extension PRUseCaseImpl: PRUseCase {
    func fetchPRList(_ url: URL, page: Int, completion: @escaping PRListHandler) {
        let model = PRListRequestModel(path: url, page: page)
        repRepository.fetchPRList(request: model, completion: completion)
    }

    func fetchPR(_ pullRequest: PullRequest, completion: @escaping PRHandler) {
        repRepository.fetchPR(pullRequest, completion: completion)
    }

    func fetchComments(_ request: CommentsRequestModel<PullRequest>, completion: @escaping CommentsHandler) {
        repRepository.fetchPullRequestComments(request: request, completion: completion)
    }

    func fetchDiff(_ url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        repRepository.fetchDiff(url, completion: completion)
    }
}
