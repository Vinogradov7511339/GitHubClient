//
//  RepositoriesListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import UIKit

class RepositoriesListViewController: UIViewController {
    
    var presenter: RepositoriesListPresenterInput!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private lazy var cellManager: TableCellManager = {
        let cellManager: TableCellManager
        switch presenter.type {
        case .allMy(_):
            cellManager = TableCellManager.create(cellType: DetailTableViewCell.self)
        case .iHasAccessTo(_):
            cellManager = TableCellManager.create(cellType: MyReposTableViewCell.self)
        case .starred(_):
            cellManager = TableCellManager.create(cellType: StarredRepoTableViewCell.self)
        }
        return cellManager
    }()

    private var viewModels: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        cellManager.register(tableView: tableView)
        configureNavBar()
        
        presenter?.viewDidLoad()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.refresh()
    }
}

// MARK: - RepositoriesListPresenterOutput
extension RepositoriesListViewController: RepositoriesListPresenterOutput {
    func display(viewModels: [Any]) {
        self.viewModels = viewModels
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func push(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension RepositoriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.openRepository(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension RepositoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
    
}

// MARK: - setup views
private extension RepositoriesListViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureNavBar() {
        switch presenter.type {
        case .allMy(_):
            title = "Repositories"
            navigationController?.navigationBar.prefersLargeTitles = true
        case .iHasAccessTo(_):
            title = "Repositories"
            navigationController?.navigationBar.prefersLargeTitles = false
        case .starred(_):
            title = "Starred"
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
}
