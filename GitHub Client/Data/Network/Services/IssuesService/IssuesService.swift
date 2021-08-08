//
//  IssuesService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation
import Networking

class IssuesService: NetworkServiceOld {
    
    func fetchIssue(url: URL, completion: @escaping (IssueResponseDTO?, Error?) -> Void) {
        //todo
    }
    
    func getAllIssues(parameters: IssuesFilters, completion: @escaping ([IssueResponseDTO]?, Error?) -> Void) {
        let endpoint = IssuesEndpoits.issues(parameters: parameters)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            if let issues = self.decode(of: [IssueResponseDTO].self, from: data) {
                completion(issues, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
}
