//
//  IssuesListConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

enum IssueType {
    case issue
    case pullRequest
    case discussions
}

class IssuesListConfigurator {
    static func createModule(with type: IssueType) -> IssuesViewController {
        let interactor = IssuesInteractor(type: type)
        let presenter = IssuesPresenter(type: type)
        presenter.interactor = interactor
        presenter.interactor?.output = presenter
        
        let viewController = IssuesViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
