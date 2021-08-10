//
//  IssueRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

protocol IssueRepository {
    func fetchComments(requestModel: IssueRequestModel,
                       completion: @escaping (Result<IssueResponseModel, Error>) -> Void)
}
