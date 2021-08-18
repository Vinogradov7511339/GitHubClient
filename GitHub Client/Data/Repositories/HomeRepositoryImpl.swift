//
//  HomeRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

final class HomeRepositoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - HomeRepository
extension HomeRepositoryImpl: HomeRepository {
    func fetchRecent(completion: @escaping (Result<[IssueResponseDTO], Error>) -> Void) {
        completion(.success([]))
    }

    func fetchRepositories(completion: @escaping (Result<[Repository], Error>) -> Void) {
        let endpoint = MyProfileEndpoinds.getMyRepositories(page: 1)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.model.compactMap { $0.toDomain() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
