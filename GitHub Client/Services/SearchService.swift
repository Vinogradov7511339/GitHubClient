//
//  SearchService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import Foundation
import Networking

enum SearchType: String {
    case repositories = "repositories"
    case issues = "Issues"
    case pullRequests = ""
    case people = "Users"
    case organizations = "Organizations" //todo change
    case all = "all" // todo change
}

class SearchService: NetworkService {
    func search<T: Codable>(text: String, type: SearchType, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        let endpoint = Endpoint.search(type: type, text: text)
        let url = URL(string: "https://api.github.com/search/issues?q=is:issue+windows+label:bug+language:python+state:open&sort=created&order=asc")!
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        urlRequest.allHTTPHeaderFields = endpoint.headers
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let models = self.decode(of: T.self, from: data) {
                completion(models, nil)
            } else if let errorResponse = self.decode(of: ErrorResponse.self, from: data) {
                NotificationCenter.default.post(name: Notification.Name.NetworkService.CriticalError, object: nil, userInfo: ["errorInfo" : errorResponse])
                completion(nil, error)
                return
            }
            completion(nil, error)
        }
    }
}
