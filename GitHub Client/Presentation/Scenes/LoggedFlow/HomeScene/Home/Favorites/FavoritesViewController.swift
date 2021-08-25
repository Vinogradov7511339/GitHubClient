//
//  FavoritesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    var viewModel: FavoritesViewModel!

    static func create(with viewModel: FavoritesViewModel) -> FavoritesViewController {
        let viewController = FavoritesViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
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
    private var models: [[Any]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        cellManager.register(tableView: tableView)
        configureNavigationBar()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func doneTarget(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Binding
private extension FavoritesViewController {
    func bind(to viewModel: FavoritesViewModel) {
        viewModel.models.observe(on: self) { [weak self] models in self?.update(models) }
        viewModel.updates.observe(on: self) { [weak self] items in self?.updateTableView(items: items) }
    }

    func update(_ models: [[Any]]) {
        self.models = models
        tableView.reloadData()
    }

    func updateTableView(items: FavoritesViewModelOutput.UpdatedItems) {
        self.models = items.viewModels
        tableView.beginUpdates()
        tableView.deleteRows(at: items.deletedObjects, with: .fade)
        tableView.insertRows(at: items.insertedObjects, with: .fade)
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
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = models[indexPath.section][indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
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
