//
//  IssuesService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

class IssuesService: NetworkService {
    
    func fetchIssue(url: URL, completion: @escaping (Issue?, Error?) -> Void) {
        //todo
    }
    
    func getAllIssues(completion: @escaping ([Issue]?, Error?) -> Void) {
        let path = "https://api.github.com/issues"
        guard let url = url(base: path, queryItems: Endpoint.allIssue.query) else {
            return
        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        for header in Endpoint.allIssue.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        request.cachePolicy = .reloadIgnoringCacheData
        self.request(request as URLRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let issues = self.decode(of: [Issue].self, from: data) {
                completion(issues, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
}
