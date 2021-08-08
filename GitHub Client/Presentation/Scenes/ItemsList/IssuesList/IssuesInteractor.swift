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
    func didReceive(pullRequests: [PullRequest])
    func didReceive(discussions: [CommentResponse])
}

class IssuesInteractor {
    weak var output: IssuesInteractorOutput?
    
    private let type: IssueType
    private let issueService = ServicesManager.shared.issuesService
    private let repositoryService = ServicesManager.shared.repositoryService
    private var issueFilters = FilterStorage.shared.getIssuesFilter()
    
    init(type: IssueType) {
        self.type = type
    }
}

// MARK: - IssuesInteractorInput
extension IssuesInteractor: IssuesInteractorInput {
    func fetchObjects() {
        switch self.type {
        case .myIssues: fetchMyIssues()
        case .myPullRequests: fetchMyPullRequests()
        case .myDiscussions: fetchMyDiscussions()
            
        case .issues(let repository):
            fetchIssues(repository: repository)
            
        case .pullRequests(let repository):
            fetchPullRequests(repository: repository)
            
        case .discussions(let repository):
            fetchDiscussions(repository: repository)
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
    func fetchMyIssues() {
        output?.didReceive(objects: [])
        issueService.getAllIssues(parameters: issueFilters) { issues, error in
            if let issues = issues {
                self.output?.didReceive(objects: issues)
            }
        }
    }

    func fetchMyPullRequests() {
        
    }

    func fetchMyDiscussions() {
        
    }

    func fetchIssues(repository: RepositoryResponse) {
    }

    func fetchPullRequests(repository: RepositoryResponse) {
        repositoryService.fetchPullRequests(for: repository) { pullRequests, error in
            if let pullRequests = pullRequests {
                self.output?.didReceive(pullRequests: pullRequests)
            }
        }
    }
    
    func fetchDiscussions(repository: RepositoryResponse) {
        repositoryService.fetchDiscussions(for: repository) { discussions, error in
            if let discussions = discussions {
                self.output?.didReceive(discussions: discussions)
            }
        }
    }
}
