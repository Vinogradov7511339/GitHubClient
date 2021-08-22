//
//  FolderViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

final class FolderViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: FolderViewModel) -> FolderViewController {
        let viewController = FolderViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Private variables

    private var viewModel: FolderViewModel!
}
