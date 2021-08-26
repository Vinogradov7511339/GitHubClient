//
//  IssueUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import Foundation

protocol IssueUseCase {
    typealias IssuesHandler = RepRepository.IssuesHandler
    func fetchAllIssues(_ repository: Repository, page: Int, completion: @escaping IssuesHandler)
    func fetchOpenIssues(_ repository: Repository, page: Int, completion: @escaping IssuesHandler)
    func fetchCloseIssues(_ repository: Repository, page: Int, completion: @escaping IssuesHandler)

    typealias IssueHandler = RepRepository.IssueHandler
    func fetchIssue(_ request: IssueRequestModel, completion: @escaping IssueHandler)

    typealias CommentsHandler = RepRepository.CommentsHandler
    func fetchComments(_ request: CommentsRequestModel<Issue>, completion: @escaping CommentsHandler)
}

final class IssueUseCaseImpl {

    private let repRepository: RepRepository
    private let filterStorage: IssueFilterStorage

    init(repRepository: RepRepository, filterStorage: IssueFilterStorage) {
        self.repRepository = repRepository
        self.filterStorage = filterStorage
    }
}

// MARK: - IssueUseCase
extension IssueUseCaseImpl: IssueUseCase {
    func fetchAllIssues(_ repository: Repository, page: Int, completion: @escaping IssuesHandler) {
        let filter = filterStorage.filter(for: .all)
        let model = IssuesRequestModel(page: page, repository: repository, filter: filter)
        repRepository.fetchIssues(request: model, completion: completion)
    }

    func fetchOpenIssues(_ repository: Repository, page: Int, completion: @escaping IssuesHandler) {
        let filter = filterStorage.filter(for: .open)
        let model = IssuesRequestModel(page: page, repository: repository, filter: filter)
        repRepository.fetchIssues(request: model, completion: completion)
    }

    func fetchCloseIssues(_ repository: Repository, page: Int, completion: @escaping IssuesHandler) {
        let filter = filterStorage.filter(for: .close)
        let model = IssuesRequestModel(page: page, repository: repository, filter: filter)
        repRepository.fetchIssues(request: model, completion: completion)
    }

    func fetchIssue(_ request: IssueRequestModel, completion: @escaping IssueHandler) {
        repRepository.fetchIssue(request: request, completion: completion)
    }

    func fetchComments(_ request: CommentsRequestModel<Issue>, completion: @escaping CommentsHandler) {
        repRepository.fetchIssueComments(request: request, completion: completion)
    }
}
