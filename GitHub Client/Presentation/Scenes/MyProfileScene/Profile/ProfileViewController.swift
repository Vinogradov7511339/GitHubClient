//
//  ProfileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

final class ProfileViewController: UIViewController {

    static func create(with viewModel: ProfileViewModel) -> ProfileViewController {
        let viewController = ProfileViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private var viewModel: ProfileViewModel!

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.dataSource = adapter
        return tableView
    }()

    private lazy var adapter: ProfileAdapter = {
        let adapter = ProfileAdapterImpl()
        return adapter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension ProfileViewController {
    func bind(to viewModel: ProfileViewModel) {
        viewModel.user.observe(on: self) { [weak self] in self?.update($0) }
    }

    func update(_ profile: UserDetails?) {
        guard let profile = profile else {
            return
        }
        adapter.update(with: profile)
        tableView.reloadData()
    }
}

private extension ProfileViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
