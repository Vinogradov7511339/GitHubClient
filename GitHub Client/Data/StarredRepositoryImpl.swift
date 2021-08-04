//
//  StarredRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

struct CustomError: Error { }

final class StarredRepositoryImpl: StarredRepository {
    
    private let service = ServicesManager.shared.userService
    
    func fetchStarred(page: Int, login: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        service.fetchStarredRepos(login: login) { repositories, error in
            if let repositories = repositories {
                let mapped = repositories.map { $0.map() }
                completion(.success(mapped))
            } else {
                completion(.failure(CustomError()))
            }
        }
    }
}
