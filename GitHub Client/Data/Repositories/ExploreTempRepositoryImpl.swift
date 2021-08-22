//
//  ExploreTempRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

final class ExploreTempRepositoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ExploreTempRepository
extension ExploreTempRepositoryImpl: ExploreTempRepository {
    func fetch(_ searchModel: SearchRequestModel, completion: @escaping RepositoriesHandler) {
        let endpoint = ExploreTempEndpoints.repositories(searchModel)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                print(response)
                let repositories = response.model.items.compactMap { $0.toDomain() }
                let lastPage = response.httpResponse?.lastPage ?? 1
                let model = ListResponseModel<Repository>(items: repositories, lastPage: lastPage)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
