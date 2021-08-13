//
//  IssueRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import Foundation

final class IssueRepositoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - IssueRepository
extension IssueRepositoryImpl: IssueRepository {
    func fetchIssues(requestModel: IssuesRequestModel, completion: @escaping (Result<IssuesResponseModel, Error>) -> Void) {
        let endpoint: Endpoint<[IssueResponseDTO]>
        switch requestModel.issuesType {
        case .myIssues:
            endpoint = MyProfileEndpoinds.getMyIssues(page: requestModel.page)
        case .issues(let repository):
            endpoint = RepositoryEndpoits.getIssues(page: requestModel.page, repository: repository)
        }

        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let issues = response.model.compactMap { $0.toDomain() }
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let responseModel = IssuesResponseModel(items: issues, lastPage: lastPage)
                completion(.success(responseModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchComments(requestModel: IssueRequestModel,
                       completion: @escaping (Result<IssueResponseModel, Error>) -> Void) {
        let endpoint = IssueEndpoints.getComments(model: requestModel)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let comments = response.model.map { $0.toDomain() }
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let responseModel = IssueResponseModel(comments: comments, lastPage: lastPage)
                completion(.success(responseModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension IssueRepositoryImpl {

    func tryTakeLastPage(_ response: HTTPURLResponse?) -> Int {
        var count = 1
        if let linkBody = response?.allHeaderFields["Link"] as? String {
            if let newCount = linkBody.maxPageCount() {
                count = newCount
            }
        }
        return count
    }
}
