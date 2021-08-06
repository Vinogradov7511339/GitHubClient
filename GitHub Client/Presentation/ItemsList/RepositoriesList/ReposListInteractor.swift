//
//  ReposListInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.07.2021.
//

import Foundation

protocol ReposListInteractorInput {
    var output: ReposListInteractorOutput? { get set }
    
    func fetchRepos()
}

protocol ReposListInteractorOutput: AnyObject {
    func didReceive(repos: [RepositoryResponse])
}

class ReposListInteractor {
    weak var output: ReposListInteractorOutput?
    
    private let service = ServicesManager.shared.userService
    private let type: RepositoriesType
    
    init(type: RepositoriesType) {
        self.type = type
    }
}

// MARK: - ReposListInteractorInput
extension ReposListInteractor: ReposListInteractorInput {
    func fetchRepos() {
        switch type {
        case .allMy(let profile):
            fetchAll(profile)
        case .iHasAccessTo(let profile):
            fetchAll(profile)
        case .starred(let profile):
            fetchStarred(profile)
        }
    }
}

// MARK: - private
private extension ReposListInteractor {
    func fetchStarred(_ profile: UserResponseDTO) {
        service.fetchStarredRepos(profile) { [weak self] repositories, error in
            if let repositories = repositories {
                DispatchQueue.main.async {
                    self?.output?.didReceive(repos: repositories)
                }
            }
        }
    }
    
    func fetchAll(_ profile: UserResponseDTO) {
        service.fetchRepositories(profile) { [weak self] repositories, error in
            if let repositories = repositories {
                DispatchQueue.main.async {
                    self?.output?.didReceive(repos: repositories)
                }
            }
        }
    }
}
