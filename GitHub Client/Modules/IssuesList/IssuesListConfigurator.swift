//
//  IssuesListConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

class IssuesListConfigurator {
    static func createModule(from issues: [Issue]) -> IssuesViewController {
        let presenter = IssuesPresenter(with: issues)
        let viewController = IssuesViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
