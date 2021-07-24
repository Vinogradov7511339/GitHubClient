//
//  MyWorkInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

protocol HomeInteractorInput {
    var output: HomeInteractorOutput? { get set }
    
    func fetchAllIssues()
}

protocol HomeInteractorOutput: AnyObject {
    func didReceive(allIssues: [Issue])
    func didReceive(error: Error)
}

class HomeInteractor {
    var output: HomeInteractorOutput?
    
    private let issueService = ServicesManager.shared.issuesService
}

// MARK: - MyWorkInteractorInput
extension HomeInteractor: HomeInteractorInput {
    func fetchAllIssues() {
        issueService.getAllIssues { [weak self] issues, error in
            if let issues = issues {
                self?.output?.didReceive(allIssues: issues)
                return
            }
            if let error = error {
                self?.output?.didReceive(error: error)
            }
        }
    }
}
