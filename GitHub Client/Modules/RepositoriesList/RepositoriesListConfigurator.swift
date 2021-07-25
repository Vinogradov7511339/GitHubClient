//
//  RepositoriesListConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

enum RepositoriesType {
    case iHasAccessTo(repositories: [Repository])
    case allMy(repositories: [Repository])
    case starred(repositories: [Repository])
}

class RepositoriesListConfigurator {
    static func createModule(with type: RepositoriesType) -> RepositoriesListViewController {
        let presenter = RepositoriesListPresenter(with: type)
        let viewController = RepositoriesListViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
