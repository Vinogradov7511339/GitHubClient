//
//  CommitsListConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class CommitsListConfigurator {
    static func create(repository: RepositoryResponseDTO) -> CommitsListViewController {
        let presenter = CommitsListPresenter(repository)
        let viewController = CommitsListViewController()
        viewController.presenter = presenter
        viewController.presenter.output = viewController
        return viewController
    }
}
