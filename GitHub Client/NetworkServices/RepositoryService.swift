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
        let path = "https://api.github.com/user/repos"
        guard let url = url(base: path, queryItems: Endpoint.repositories.query) else {
            return
        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        for header in Endpoint.repositories.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        request.cachePolicy = .reloadIgnoringCacheData
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [weak self] data, response, error in
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
    
    func mostPopularRepositories(completion: @escaping (RepositoriesResponse?, Error?) -> Void) {
        let path = "https://api.github.com/search/repositories"
        guard let url = url(base: path, queryItems: Endpoint.mostPopularRepositories.query) else {
            return
        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        for header in Endpoint.mostPopularRepositories.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        request.cachePolicy = .reloadIgnoringCacheData
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
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
        task.resume()
    }
}
