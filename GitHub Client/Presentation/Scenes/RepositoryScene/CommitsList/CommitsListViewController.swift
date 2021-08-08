//
//  CommitsListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class CommitsListViewController: UIViewController {
    var presenter: CommitsListPresenterInput!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let cellManager = TableCellManager.create(cellType: CommitTableViewCell.self)
    private var viewModels: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        cellManager.register(tableView: tableView)
        configureNavigationBar()
        presenter.viewDidLoad()
    }
}

// MARK: - FavoritesPresenterOutput
extension CommitsListViewController: CommitsListPresenterOutput {
    func display(viewModels: [Any]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    func push(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension CommitsListViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource
extension CommitsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

// MARK: - setup views
private extension CommitsListViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func configureNavigationBar() {
        title = "Commits"
//        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
}
