//
//  BranchesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.08.2021.
//

import UIKit

final class BranchesViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: BranchesViewModel) -> BranchesViewController {
        let viewController = BranchesViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()

    // MARK: - Private variables

    private var viewModel: BranchesViewModel!
    private let cellManager = TableCellManager.create(cellType: BranchCell.self)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        configureNavBar()
        cellManager.register(tableView: tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Actions

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Binding
private extension BranchesViewController {
    func bind(to viewModel: BranchesViewModel) {
        viewModel.branches.observe(on: self) { [weak self] _ in self?.update() }
    }

    func update() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension BranchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.branches.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let branch = viewModel.branches.value[indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: branch)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BranchesViewController: UITableViewDelegate {

}

// MARK: - Setup views
private extension BranchesViewController {
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
        title = NSLocalizedString("Choose Branch", comment: "")
        navigationItem.searchController = searchController
        let close = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        navigationItem.setLeftBarButton(close, animated: true)
    }
}
