//
//  FileConfigurator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class FileConfigurator {
    static func create(from filePath: URL) -> FileViewController {
        let presenter = FilePresenter(filePath)
        let viewController = FileViewController()
        viewController.presenter = presenter
        viewController.presenter.output = viewController
        return viewController
    }
}
