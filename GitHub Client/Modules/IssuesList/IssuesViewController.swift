//
//  IssuesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

class IssuesViewController: UIViewController {
    
    var presenter: IssuesPresenterInput!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search GitHub"
        return searchController
    }()
    
    private lazy var filterView: FilterView = {
        let filterView = FilterView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40.0))
//        filterView.delegate = presenter
        return filterView
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
        
        tableView.tableHeaderView = filterView
        cellManager.register(tableView: tableView)
        
        configureNavBar()
        presenter?.viewDidLoad()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.refresh()
    }
    
    @objc func addFilter(_ sender: AnyObject) {
        presenter?.addFilter()
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
    
    func display(filter: IssuesFilters) {
        let viewModel = IssuesFilterViewModel(issueParams: filter)
        viewModel.output = filterView
        viewModel.listener = presenter
        filterView.configure(with: viewModel)
    }
    
    func push(to viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
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
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func configureNavBar() {
        title = presenter.title

        if presenter.shouldShowAddButton {
            let addFilterButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addFilter(_:)))
            self.navigationItem.rightBarButtonItem  = addFilterButton
        }

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
