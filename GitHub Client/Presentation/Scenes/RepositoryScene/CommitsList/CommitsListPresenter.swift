//
//  CommitsListPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

protocol CommitsListPresenterInput {
    var output: CommitsListPresenterOutput? { get set }
    
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

protocol CommitsListPresenterOutput: AnyObject {
    func display(viewModels: [Any])
    func push(to viewController: UIViewController)
}

class CommitsListPresenter {
    var output: CommitsListPresenterOutput?

    private let repository: RepositoryResponseDTO
    
    init(_ repository: RepositoryResponseDTO) {
        self.repository = repository
    }
}

// MARK: - FavoritesPresenterInput
extension CommitsListPresenter: CommitsListPresenterInput {
    func viewDidLoad() {
        fetchCommits()
    }

    func didSelectRow(at indexPath: IndexPath) {
    }
}

// MARK: - private
private extension CommitsListPresenter {
    func fetchCommits() {
    }

}
