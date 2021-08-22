//
//  SettingsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: SettingsViewModel) -> SettingsViewController {
        let viewController = SettingsViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.dataSource = adapter
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: SettingsViewModel!

    private lazy var adapter: SettingsAdapter = {
        let adapter = SettingsAdapterImpl(viewModel.profile.value.userDetails.user)
        return adapter
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()
        adapter.register(tableView)
    }
}

// MARK: - Setup views
private extension SettingsViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

    func configureNavBar() {
        title = NSLocalizedString("Settings", comment: "")
    }
}
