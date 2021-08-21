//
//  IssueUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import Foundation

protocol IssueUseCase {
    typealias IssuesHandler = RepRepository.IssuesHandler
    func fetchIssues(_ request: IssuesRequestModel, completion: @escaping IssuesHandler)

    typealias IssueHandler = RepRepository.IssueHandler
    func fetchIssue(_ request: IssueRequestModel, completion: @escaping IssueHandler)

    typealias CommentsHandler = RepRepository.CommentsHandler
    func fetchComments(_ request: CommentsRequestModel<Issue>, completion: @escaping CommentsHandler)
}

final class IssueUseCaseImpl {

    private let repRepository: RepRepository

    init(repRepository: RepRepository) {
        self.repRepository = repRepository
    }
}

// MARK: - IssueUseCase
extension IssueUseCaseImpl: IssueUseCase {
    func fetchIssues(_ request: IssuesRequestModel, completion: @escaping IssuesHandler) {
        repRepository.fetchIssues(request: request, completion: completion)
    }

    func fetchIssue(_ request: IssueRequestModel, completion: @escaping IssueHandler) {
        repRepository.fetchIssue(request: request, completion: completion)
    }

    func fetchComments(_ request: CommentsRequestModel<Issue>, completion: @escaping CommentsHandler) {
        repRepository.fetchIssueComments(request: request, completion: completion)
    }
}
