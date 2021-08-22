//
//  ExploreTempViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class ExploreTempViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: ExploreTempViewModel) -> ExploreTempViewController {
        let viewController = ExploreTempViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Private variables

    private var viewModel: ExploreTempViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        activateConstraints()
        configureNavBar()
    }
}

// MARK: - ExploreTempViewController
private extension ExploreTempViewController {
    func setupViews() {}

    func activateConstraints() {}

    func configureNavBar() {
        title = NSLocalizedString("Explore", comment: "")
    }
}
