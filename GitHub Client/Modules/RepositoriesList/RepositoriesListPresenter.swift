//
//  RepositoriesListPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit


protocol RepositoriesListPresenterInput {
    var output: RepositoriesListPresenterOutput? { get set }
    var type: RepositoriesType { get }
    
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
    var interactor: ReposListInteractorInput?
    
    private let repositoryService = ServicesManager.shared.repositoryService
    private var repositories: [RepositoryResponse] = []
    var type: RepositoriesType
    
    init(with type: RepositoriesType) {
        self.type = type
    }
}

// MARK: - RepositoriesListPresenterInput
extension RepositoriesListPresenter: RepositoriesListPresenterInput {
    func viewDidLoad() {
        interactor?.fetchRepos()
    }
    
    func refresh() {
        interactor?.fetchRepos()
    }
    
    func openRepository(at indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        let viewController = RepositoryConfigurator.createModule(for: repository)
        output?.push(to: viewController)
    }
}

// MARK: - ReposListInteractorOutput
extension RepositoriesListPresenter: ReposListInteractorOutput {
    func didReceive(repos: [RepositoryResponse]) {
        self.repositories = repos
        switch type {
        case .allMy(_):
            let viewModels = repositories.map { DetailCellViewModel(repository: $0) }
            self.output?.display(viewModels: viewModels)
        case .iHasAccessTo(_):
            self.output?.display(viewModels: repos)
        case .starred(_):
            self.output?.display(viewModels: repos)
        }
    }
}
