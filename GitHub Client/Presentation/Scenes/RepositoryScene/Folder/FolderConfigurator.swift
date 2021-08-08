//
//  FolderConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class FolderConfigurator {
    static func create(from filePath: URL) -> FolderViewController {
        let presenter = FolderPresenter(filePath)
        let viewController = FolderViewController()
        viewController.presenter = presenter
        viewController.presenter.output = viewController
        return viewController
    }
}
