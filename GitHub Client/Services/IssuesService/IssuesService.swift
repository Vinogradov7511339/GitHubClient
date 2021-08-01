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
    
    func getAllIssues(parameters: IssueRequestParameters, completion: @escaping ([Issue]?, Error?) -> Void) {
        let endpoint = IssuesEndpoits.issues(parameters: parameters)
        request(endpoint) { data, response, error in
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
