//
//  DiffViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

final class DiffViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: DiffViewModel) -> DiffViewController {
        let viewController = DiffViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Private variables

    private var viewModel: DiffViewModel!
}
