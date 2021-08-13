//
//  IssueRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

protocol IssueRepository {
    func fetchIssues(requestModel: IssuesRequestModel,
                     completion: @escaping (Result<IssuesResponseModel, Error>) -> Void)
    func fetchComments(requestModel: IssueRequestModel,
                       completion: @escaping (Result<IssueResponseModel, Error>) -> Void)
}
