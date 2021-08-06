//
//  UserService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import Foundation
import Networking

class UserService: NetworkService {
    
    func fetchRepositories(_ user: UserResponseDTO, completion: @escaping ([RepositoryResponse]?, Error?) -> Void) {
        let endpoint = UserEndpoints.repositories(user: user)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let repositories = self.decode(of: [RepositoryResponse].self, from: data) else {
                completion(nil, error)
                return
            }
            completion(repositories, error)
        }
    }
    
    func fetchPopularRepositories(_ user: UserResponseDTO, completion: @escaping ([RepositoryResponse]?, Error?) -> Void) {
        let endpoint = UserEndpoints.popularRepos(user: user)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let repositories = self.decode(of: [RepositoryResponse].self, from: data) else {
                completion(nil, error)
                return
            }
            completion(repositories, error)
        }
    }
    
    func fetchStarredCountRepositories(_ user: UserResponseDTO, completion: @escaping (Int?, Error?) -> Void) {
        let endpoint = UserEndpoints.starredReposCount(user: user)
        request(endpoint) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            guard let linkBody = response.allHeaderFields["Link"] as? String else {
                completion(nil, error)
                return
            }
            
            guard let count = linkBody.maxPageCount() else {
                completion(nil, error)
                return
            }
            completion(count, error)
        }
    }
    
    func fetchStarredRepos(login: String, completion: @escaping ([RepositoryResponse]?, Error?) -> Void) {
        let endpoint = UserEndpoints.starred2(login: login)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let repositories = self.decode(of: [RepositoryResponse].self, from: data) else {
                completion(nil, error)
                return
            }
            completion(repositories, error)
        }
    }
    
    func fetchStarredRepos(_ user: UserResponseDTO, completion: @escaping ([RepositoryResponse]?, Error?) -> Void) {
        let endpoint = UserEndpoints.starred(user: user)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let repositories = self.decode(of: [RepositoryResponse].self, from: data) else {
                completion(nil, error)
                return
            }
            completion(repositories, error)
        }
    }
    
    func fetchFollowers(_ user: UserResponseDTO, completion: @escaping ([UserResponseDTO]?, Error?) -> Void) {
        let endpoint = UserEndpoints.followers(user: user)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let repositories = self.decode(of: [UserResponseDTO].self, from: data) else {
                completion(nil, error)
                return
            }
            completion(repositories, error)
        }
    }
    
    func fetchFollowing(_ user: UserResponseDTO, completion: @escaping ([UserResponseDTO]?, Error?) -> Void) {
        let endpoint = UserEndpoints.following(user: user)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let repositories = self.decode(of: [UserResponseDTO].self, from: data) else {
                completion(nil, error)
                return
            }
            completion(repositories, error)
        }
    }
    
    func fetchSubscriptions(_ user: UserResponseDTO, completion: @escaping ([Any]?, Error?) -> Void) {
        let endpoint = UserEndpoints.followers(user: user)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
        }
    }
    
    func fetchOrganizations(_ user: UserResponseDTO, completion: @escaping ([Any]?, Error?) -> Void) {
        let endpoint = UserEndpoints.organizations(user: user)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
        }
    }
    
    func fetchProfile(user: UserResponseDTO, completion: @escaping (UserResponseDTO?, Error?) -> Void) {
        let endpoint = UserEndpoints.profile(user: user)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let userProfile = self.decode(of: UserResponseDTO.self, from: data) else {
                completion(nil, error)
                return
            }
            completion(userProfile, error)
        }
    }
    
    func fetchMyProfile(token: TokenResponse, completion: @escaping (UserResponseDTO?, Error?) -> Void) {
        let endpoint = UserEndpoints.myProfileWithToken(token: token)
        request(endpoint) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                fatalError("should be HTTPURLResponse")
            }
//            self.saveCashe(for: response, responseType: .myProfile)
            
            let result = self.handle(data: data, response: response, error: error)
            switch result {
            case.success(let data):
                if let profile = self.decode(of: UserResponseDTO.self, from: data) {
                    completion(profile, nil)
                } else {
                    completion(nil, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func fetchMyProfile(completion: @escaping (UserResponseDTO?, Error?) -> Void) {
        let endpoint = UserEndpoints.myProfile
        request(endpoint) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                fatalError("should be HTTPURLResponse")
            }
//            self.saveCashe(for: response, responseType: .myProfile)
            
            let result = self.handle(data: data, response: response, error: error)
            switch result {
            case.success(let data):
                if let profile = self.decode(of: UserResponseDTO.self, from: data) {
                    completion(profile, nil)
                } else {
                    completion(nil, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
