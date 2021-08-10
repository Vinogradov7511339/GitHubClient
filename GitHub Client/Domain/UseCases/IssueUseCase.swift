//
//  IssueUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import Foundation

struct IssueRequestModel {
    let issue: Issue
    let page: Int
}

struct IssueResponseModel {
    let comments: [Comment]
    let lastPage: Int
}

protocol IssueUseCase {
    func fetchComments(requestModel: IssueRequestModel,
                       completion: @escaping (Result<IssueResponseModel, Error>) -> Void)
}

final class IssueUseCaseImpl {

    private let repository: IssueRepository

    init(repository: IssueRepository) {
        self.repository = repository
    }
}

// MARK: - IssueUseCase
extension IssueUseCaseImpl: IssueUseCase {
    func fetchComments(requestModel: IssueRequestModel,
                       completion: @escaping (Result<IssueResponseModel, Error>) -> Void) {
        repository.fetchComments(requestModel: requestModel, completion: completion)
    }
}
