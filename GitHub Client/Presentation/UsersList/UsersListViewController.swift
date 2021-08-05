//
//  UsersListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import UIKit

class UsersListViewController: UIViewController {
    
    var presenter: UsersListPresenter!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    private let cellManager = TableCellManager.create(cellType: UserTableViewCell.self)
    private var viewModels: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        cellManager.register(tableView: tableView)
        
        switch presenter.type {
        case .followers:
            title = "Followers"
        case .following:
            title = "Following"
        }
        navigationController?.navigationBar.prefersLargeTitles = false
        presenter.viewDidLoad()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.refresh()
    }
}

// MARK: - UsersListPresenterOutput
extension UsersListViewController: UsersListPresenterOutput {
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
extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension UsersListViewController: UITableViewDataSource {
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
private extension UsersListViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
