//
//  IssuesUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol IssuesUseCase {
    typealias IssuesHandler = (Result<IssuesResponseModel, Error>) -> Void

    func fetch(request: IssuesRequestModel, completion: @escaping IssuesHandler)
}

final class IssuesUseCaseImpl {

    private let repository: IssueRepository

    init(repository: IssueRepository) {
        self.repository = repository
    }
}

// MARK: - RepositoriesUseCase
extension IssuesUseCaseImpl: IssuesUseCase {
    func fetch(request: IssuesRequestModel, completion: @escaping IssuesHandler) {
        repository.fetchIssues(requestModel: request, completion: completion)
    }
}
