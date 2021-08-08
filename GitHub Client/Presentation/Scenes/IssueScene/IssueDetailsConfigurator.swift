//
//  IssueDetailsConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

class IssueDetailsConfigurator {
    static func createModule(for issue: IssueResponseDTO) -> IssueDetailsViewController {
        let presenter = IssueDetailsPresenter(issue)
        let viewController = IssueDetailsViewController()
        viewController.presenter = presenter
        viewController.presenter?.output = viewController
        return viewController
    }
}
