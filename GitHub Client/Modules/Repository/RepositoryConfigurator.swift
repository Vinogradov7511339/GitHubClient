//
//  RepositoryDetailsConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class RepositoryConfigurator {
    static func createModule(for repository: RepositoryResponse) -> RepositoryViewController {
        let interactor = RepositoryInteractor(repository)
        let presenter = RepositoryPreseter(repository: repository)
        presenter.interactor = interactor
        presenter.interactor.output = presenter
        
        let viewController = RepositoryViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
