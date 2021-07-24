//
//  IssuesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

class IssuesViewController: UIViewController {
    
    var presenter: IssuesPresenterInput?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var searchView: SearchBarWithFiltersView = {
        let view = SearchBarWithFiltersView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.searchResultsUpdater = self
        return view
    }()
    
    private let refreshControl = UIRefreshControl()
    private let cellManager = TableCellManager.create(cellType: IssueTableViewCell.self)
    private var viewModels: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        cellManager.register(tableView: tableView)
        
        title = "Issues"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        presenter?.viewDidLoad()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.refresh()
    }
}

// MARK: - UISearchResultsUpdating
extension IssuesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        print(searchController.searchBar.text ?? "aaaa")
    }
}

// MARK: - IssuesPresenterOutput
extension IssuesViewController: IssuesPresenterOutput {
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
extension IssuesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.openIssue(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension IssuesViewController: UITableViewDataSource {
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
private extension IssuesViewController {
    func setupViews() {
        view.addSubview(searchView)
        view.addSubview(tableView)
    }

    func activateConstraints() {
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
