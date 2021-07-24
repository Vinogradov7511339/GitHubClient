//
//  RepositoryDetailsConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class RepositoryDetailsConfigurator {
    static func createModule(for repository: Repository) -> RepositoryDetailsViewController {
        let presenter = RepositoryPreseter(repository: repository)
        let viewController = RepositoryDetailsViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
