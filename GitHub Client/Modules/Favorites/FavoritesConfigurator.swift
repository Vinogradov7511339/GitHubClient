//
//  FavoritesConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class FavoritesConfigurator {
    static func create() -> UIViewController {
        let presenter = FavoritesPresenter()
        let viewController = FavoritesViewController()
        viewController.presenter = presenter
        viewController.presenter.output = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
