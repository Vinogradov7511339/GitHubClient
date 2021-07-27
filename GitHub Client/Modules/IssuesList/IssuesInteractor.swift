//
//  IssuesInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation

protocol IssuesInteractorInput {
    var output: IssuesInteractorOutput? { get set }
    func fetchObjects()
}

protocol IssuesInteractorOutput: AnyObject {
    func didReceive(objects: [Any])
}

class IssuesInteractor {
    weak var output: IssuesInteractorOutput?
    
    private let type: IssueType
    private let service = ServicesManager.shared.issuesService
    
    init(type: IssueType) {
        self.type = type
    }
}

// MARK: - IssuesInteractorInput
extension IssuesInteractor: IssuesInteractorInput {
    func fetchObjects() {
        switch self.type {
        case .issue: fetchIssues()
        case .pullRequest: fetchPullRequests()
        case .discussions: fetchDiscussions()
        }
    }
}

private extension IssuesInteractor {
    func fetchIssues() {
        service.getAllIssues { issues, error in
            if let issues = issues {
                self.output?.didReceive(objects: issues)
            }
        }
    }
    
    func fetchPullRequests() {
        
    }
    
    func fetchDiscussions() {
        
    }
}
