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

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension ExploreTempViewController {

    func bind(to viewModel: ExploreTempViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }

    func showError(_ error: Error?) {
        guard let error = error else { return }
        let alert = ErrorAlertView.create(with: error)
        alert.show(in: view)
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
