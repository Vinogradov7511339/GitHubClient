//
//  MyWorkConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

class HomeConfigurator {
    static func createHomeModule() -> HomeViewController {
        
        let presenter = HomePresenter()
        let viewController = HomeViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        
        let interactor = HomeInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        return viewController
    }
}
