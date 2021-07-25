//
//  RepositoryService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import Foundation

class RepositoryService: NetworkService {
    func getRepositories(url: URL, completion: @escaping ([Repository]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let repositories = self.decode(of: [Repository].self, from: data) {
                completion(repositories, nil)
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
    
    func allRepositoriesToWhichIHasAccess(completion: @escaping ([Repository]?, Error?) -> Void) {
        let endpoint = Endpoint.repositories
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let repositories = self.decode(of: [Repository].self, from: data) {
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
