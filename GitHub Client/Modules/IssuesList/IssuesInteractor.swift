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
    func fetchFilter()
    func updateFilter(filter: IssuesFilters)
}

protocol IssuesInteractorOutput: AnyObject {
    func didReceive(objects: [Any])
    func didReceive(filter: IssuesFilters)
}

class IssuesInteractor {
    weak var output: IssuesInteractorOutput?
    
    private let type: IssueType
    private let service = ServicesManager.shared.issuesService
    private var issueFilters = FilterStorage.shared.getIssuesFilter()
    
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
    
    func fetchFilter() {
        output?.didReceive(filter: issueFilters)
    }
    
    func updateFilter(filter: IssuesFilters) {
        self.issueFilters = filter
        print("filter updated with: \(filter), should send request")
        FilterStorage.shared.setIssueFilter(filter)
    }
}

private extension IssuesInteractor {
    func fetchIssues() {
        output?.didReceive(objects: [])
        service.getAllIssues(parameters: issueFilters) { issues, error in
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
