//
//  MyWorkInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import Foundation

protocol HomeInteractorInput {
    var output: HomeInteractorOutput? { get set }
    
//    func fetchAllIssues()
//    func fetchAllRepositoriesIHaveAccess()
}

protocol HomeInteractorOutput: AnyObject {
    func didReceive(allIssues: [Issue])
    func didReceive(allRepositoriesIHaveAccess: [RepositoryResponse])
    func didReceive(error: Error)
}

class HomeInteractor {
    var output: HomeInteractorOutput?
    
    private let issueService = ServicesManager.shared.issuesService
    private let repositoryService = ServicesManager.shared.repositoryService
}

// MARK: - MyWorkInteractorInput
extension HomeInteractor: HomeInteractorInput {
    func fetchAllIssues() {
//        issueService.getAllIssues(parameters: <#RequestParameters#>) { [weak self] issues, error in
//            if let issues = issues {
//                self?.output?.didReceive(allIssues: issues)
//                return
//            }
//            if let error = error {
//                self?.output?.didReceive(error: error)
//            }
//        }
    }
    
    func fetchAllRepositoriesIHaveAccess() {
        repositoryService.allRepositoriesToWhichIHasAccess { [weak self] repositories, error in
            if let repositories = repositories {
                self?.output?.didReceive(allRepositoriesIHaveAccess: repositories)
                return
            }
            if let error = error {
                self?.output?.didReceive(error: error)
            }
        }
    }
}
