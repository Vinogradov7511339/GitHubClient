//
//  RepRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

final class RepRepositoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - RepRepository
extension RepRepositoryImpl: RepRepository {
    func fetchCommits(request: CommitsRequestModel, completion: @escaping (Result<CommitsResponseModel, Error>) -> Void) {
        let endpoint = RepositoryEndpoits.getCommits(page: request.page, repository: request.repository)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let lastPage = self.tryTakeLastPage(response.httpResponse)
                let items = response.model.map { $0.toDomain() }
                let model = CommitsResponseModel(items: items, lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchReadMe(repository: Repository, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = RepositoryEndpoits.getReadMe(repository: repository)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let model):
                let content = model.model.content
                let decodedContent = content.fromBase64()
                completion(.success(decodedContent ?? ""))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

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
