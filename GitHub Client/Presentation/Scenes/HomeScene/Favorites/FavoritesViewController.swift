//
//  FavoritesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    var presenter: FavoritesPresenterInput!
    
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
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.isActive = true
        return searchController
    }()
    
    private let cellManager = TableCellManager.create(cellType: FavoriteRepositoryTableViewCell.self)
    private var viewModels: [[Any]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        cellManager.register(tableView: tableView)
        configureNavigationBar()
        presenter.viewDidLoad()
    }
    
    @objc func doneTarget(_ sender: AnyObject) {
        
    }
}

// MARK: - FavoritesPresenterOutput
extension FavoritesViewController: FavoritesPresenterOutput {
    func display(viewModels: [[Any]]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    func updateTableView(deletedObjects: [IndexPath], insertedObjects: [IndexPath], viewModels: [[Any]]) {
        self.viewModels = viewModels
        tableView.beginUpdates()
        tableView.deleteRows(at: deletedObjects, with: .fade)
        tableView.insertRows(at: insertedObjects, with: .fade)
        tableView.endUpdates()
    }
}

// MARK: - UISearchResultsUpdating
extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //todo
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 56.0 : 32.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.section][indexPath.row]
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
private extension FavoritesViewController {
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
        title = "Repositories"
        navigationItem.searchController = searchController
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTarget(_:)))
        navigationItem.rightBarButtonItem = button
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
}
