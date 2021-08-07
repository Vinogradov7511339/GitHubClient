//
//  MyProfileRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

class MyProfileRepositoryImpl: MyProfileRepository {

    private let service = ServicesManager.shared.userService

    func fetch(completion: @escaping (Result<AuthenticatedUser, Error>) -> Void) {
        service.fetchMyProfile { response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let mappedUser = response?.mapToAuthotization() else {
                completion(.failure(GitHubAPIError()))
                return
            }
            DispatchQueue.main.async {
                completion(.success(mappedUser))
            }
        }
    }
}
