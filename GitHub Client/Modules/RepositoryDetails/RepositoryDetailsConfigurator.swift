//
//  RepositoryDetailsConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class RepositoryDetailsConfigurator {
    static func createModule(for repository: Repository) -> RepositoryDetailsViewController {
        let interactor = RepositoryDetailsInteractor(repository)
        let presenter = RepositoryPreseter(repository: repository)
        presenter.interactor = interactor
        presenter.interactor.output = presenter
        
        let viewController = RepositoryDetailsViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
