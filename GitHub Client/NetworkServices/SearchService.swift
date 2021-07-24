//
//  SearchService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import Foundation

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
        guard let url = url(url: endpoint.path, queryItems: endpoint.query) else {
            return
        }
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        for header in endpoint.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
//        request.cachePolicy = .reloadIgnoringCacheData
        let urlRequest = request as URLRequest
        self.request(urlRequest) { data, response, error in
            
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
