//
//  RepositoriesListPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit


protocol RepositoriesListPresenterInput {
    var output: RepositoriesListPresenterOutput? { get set }
    
    func viewDidLoad()
    func refresh()
    
    func openRepository(at indexPath: IndexPath)
}

protocol RepositoriesListPresenterOutput: AnyObject {
    func display(viewModels: [Any])
    
    func push(to viewController: UIViewController)
}

class RepositoriesListPresenter {
    weak var output: RepositoriesListPresenterOutput?
    
    private let repositoryService = ServicesManager.shared.repositoryService
    private var repositories: [Repository] = []
}

// MARK: - RepositoriesListPresenterInput
extension RepositoriesListPresenter: RepositoriesListPresenterInput {
    func viewDidLoad() {
        fetchRepositories()
    }
    
    func refresh() {
        fetchRepositories()
    }
    
    func openRepository(at indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        let viewController = RepositoryDetailsConfigurator.createModule(for: repository)
        output?.push(to: viewController)
    }
}

// MARK: - private
private extension RepositoriesListPresenter {
    func fetchRepositories() {
        repositoryService.allRepositoriesToWhichIHasAccess { [weak self] repositories, error in
            if let repositories = repositories {
                self?.repositories = repositories
                let viewModels = repositories.map { DetailCellViewModel(repository: $0) }
                DispatchQueue.main.async {
                    self?.output?.display(viewModels: viewModels)
                }
                return
            }
            if let error = error {
                print(error)
            }
        }
    }
}
