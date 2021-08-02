//
//  RepositoryService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import Foundation
import Networking

class RepositoryService: NetworkService {
    func getRepositories(url: URL, completion: @escaping ([RepositoryResponse]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let repositories = self.decode(of: [RepositoryResponse].self, from: data) {
                completion(repositories, nil)
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
    
    func allRepositoriesToWhichIHasAccess(completion: @escaping ([RepositoryResponse]?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.allMyRepositories
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let repositories = self.decode(of: [RepositoryResponse].self, from: data) {
                completion(repositories, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func mostPopularRepositories(completion: @escaping (RepositoriesResponse?, Error?) -> Void) {
        let endpoint = Endpoint.mostPopularRepositories
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let repositories = self.decode(of: RepositoriesResponse.self, from: data) {
                completion(repositories, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
}

// MARK: - Repository info
extension RepositoryService {
    func fetchReadMe(for repository: RepositoryResponse, completion: @escaping (ReadmeResponse?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchReadMe(repository: repository)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let readme = self.decode(of: ReadmeResponse.self, from: data) {
                completion(readme, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func fetchPullRequests(for repository: RepositoryResponse, completion: @escaping (ReadmeResponse?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchPullRequests(repository: repository)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let readme = self.decode(of: ReadmeResponse.self, from: data) {
                completion(readme, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func fetchReleases(for repository: RepositoryResponse, completion: @escaping (ReadmeResponse?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchReleases(repository: repository)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let readme = self.decode(of: ReadmeResponse.self, from: data) {
                completion(readme, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func fetchDiscussions(for repository: RepositoryResponse, completion: @escaping (ReadmeResponse?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchDiscussions(repository: repository)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let readme = self.decode(of: ReadmeResponse.self, from: data) {
                completion(readme, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func fetchCommits(for repository: RepositoryResponse, completion: @escaping (ReadmeResponse?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchCommits(repository: repository)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let readme = self.decode(of: ReadmeResponse.self, from: data) {
                completion(readme, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func fetchBranches(for repository: RepositoryResponse, completion: @escaping (ReadmeResponse?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchBranches(repository: repository)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let readme = self.decode(of: ReadmeResponse.self, from: data) {
                completion(readme, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func fetchPullRequestCount(for repository: RepositoryResponse, completion: @escaping (Int?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchPullRequestCount(repository: repository)
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
    
    func fetchReleasesCount(for repository: RepositoryResponse, completion: @escaping (Int?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchReleasesCount(repository: repository)
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
    
    func fetchDiscussionsCount(for repository: RepositoryResponse, completion: @escaping (Int?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchDiscussionsCount(repository: repository)
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
    
    func fetchCommitsCount(for repository: RepositoryResponse, completion: @escaping (Int?, Error?) -> Void) {
        let endpoint = RepositoriesEndpoint.fetchCommitsCount(repository: repository)
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
}
