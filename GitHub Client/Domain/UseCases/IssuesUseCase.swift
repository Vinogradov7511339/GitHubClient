//
//  IssuesUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

enum IssuesType {
    case myIssues
    case issues(Repository)
}

struct IssuesRequestModel {
    let page: Int
    let issuesType: IssuesType
}

struct IssuesResponseModel {
    let items: [Issue]
    let lastPage: Int
}

protocol IssuesUseCase {
    func fetch(request: IssuesRequestModel,
               completion: @escaping (Result<IssuesResponseModel, Error>) -> Void)
}

final class IssuesUseCaseImpl {

    let repository: IssueRepository

    init(repository: IssueRepository) {
        self.repository = repository
    }
}

// MARK: - RepositoriesUseCase
extension IssuesUseCaseImpl: IssuesUseCase {
    func fetch(request: IssuesRequestModel, completion: @escaping (Result<IssuesResponseModel, Error>) -> Void) {
        repository.fetchIssues(requestModel: request, completion: completion)
    }
}
