//
//  ExploreConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class ExploreConfigurator {
    static func createModule() -> ExploreViewController {
        let presenter = ExplorePresenter()
        let viewController = ExploreViewController()
        viewController.presenter = presenter
        viewController.presenter.output = viewController
        return viewController
    }
}
