//
//  SearchConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import UIKit

class SearchConfigurator {
    static func createModule() -> SearchResultViewController {
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let viewController = SearchResultViewController()
        
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        
        presenter.interactor = interactor
        presenter.interactor?.output = presenter
        
        return viewController
    }
}
