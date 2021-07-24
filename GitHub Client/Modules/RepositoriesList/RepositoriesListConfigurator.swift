//
//  RepositoriesListConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class RepositoriesListConfigurator {
    static func createModule() -> RepositoriesListViewController {
        let presenter = RepositoriesListPresenter()
        let viewController = RepositoriesListViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
