//
//  UserProfileRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

final class UserProfileRepositoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - UserProfileRepository
extension UserProfileRepositoryImpl: UserProfileRepository {
    func fetch(user: User, completion: @escaping (Result<UserDetails, Error>) -> Void) {
        let endpoint = UserEndpoints.getProfile(login: user.login)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.model.mapToDetails()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
