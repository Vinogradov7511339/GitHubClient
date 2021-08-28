//
//  CommitViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

final class CommitViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: CommitViewModel) -> CommitViewController {
        let viewController = CommitViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Private variables

    private var viewModel: CommitViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension CommitViewController {
    func bind(to viewModel: CommitViewModel) {}
}

// MARK: - Setup views
private extension CommitViewController {
    func setupViews() {
        view.backgroundColor = .green
    }

    func activateConstraints() {}
}
