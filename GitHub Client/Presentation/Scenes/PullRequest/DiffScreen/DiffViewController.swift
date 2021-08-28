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

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: DiffViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        viewModel.viewDidLoad()
    }
}

// MARK: - Setup views
private extension DiffViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
    }

    func activateConstraints() {}
}
