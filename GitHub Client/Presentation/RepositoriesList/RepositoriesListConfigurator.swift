//
//  RepositoriesListConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

enum RepositoriesType {
    case iHasAccessTo(profile: UserProfile)
    case allMy(profile: UserProfile)
    case starred(profile: UserProfile)
}

class RepositoriesListConfigurator {
    static func createModule(with type: RepositoriesType) -> RepositoriesListViewController {
        let interactor = ReposListInteractor(type: type)
        let presenter = RepositoriesListPresenter(with: type)
        presenter.interactor = interactor
        presenter.interactor?.output = presenter
        
        let viewController = RepositoriesListViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
