//
//  IssueUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import Foundation

protocol IssueUseCase {
    typealias IssuesHandler = RepRepository.IssuesHandler
    func fetchAllIssues(_ url: URL, page: Int, completion: @escaping IssuesHandler)
    func fetchOpenIssues(_ url: URL, page: Int, completion: @escaping IssuesHandler)
    func fetchCloseIssues(_ url: URL, page: Int, completion: @escaping IssuesHandler)

    typealias IssueHandler = RepRepository.IssueHandler
    func fetchIssue(_ issue: Issue, completion: @escaping IssueHandler)

    typealias IssueCommentsHandler = RepRepository.IssueCommentsHandler
    func fetchIssueComments(_ request: CommentsRequestModel<Issue>, completion: @escaping IssueCommentsHandler)
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
    func fetchAllIssues(_ url: URL, page: Int, completion: @escaping IssuesHandler) {
        let filter = filterStorage.filter(for: .all)
        let model = IssuesRequestModel(page: page, path: url, filter: filter)
        repRepository.fetchIssues(request: model, completion: completion)
    }

    func fetchOpenIssues(_ url: URL, page: Int, completion: @escaping IssuesHandler) {
        let filter = filterStorage.filter(for: .open)
        let model = IssuesRequestModel(page: page, path: url, filter: filter)
        repRepository.fetchIssues(request: model, completion: completion)
    }

    func fetchCloseIssues(_ url: URL, page: Int, completion: @escaping IssuesHandler) {
        let filter = filterStorage.filter(for: .close)
        let model = IssuesRequestModel(page: page, path: url, filter: filter)
        repRepository.fetchIssues(request: model, completion: completion)
    }

    func fetchIssue(_ issue: Issue, completion: @escaping IssueHandler) {
        repRepository.fetchIssue(issue, completion: completion)
    }

    func fetchIssueComments(_ request: CommentsRequestModel<Issue>, completion: @escaping IssueCommentsHandler) {
        repRepository.fetchIssueComments(request, completion: completion)
    }
}
