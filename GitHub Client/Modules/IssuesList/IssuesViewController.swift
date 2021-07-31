//
//  IssuesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.07.2021.
//

import UIKit

class IssuesViewController: UIViewController {
    
    var presenter: IssuesPresenterInput!
    
    private var customNavBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
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
        
        configureNavBar()
        
        presenter?.viewDidLoad()
        
        let header = FilterView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40.0))
        tableView.tableHeaderView = header
        header.configure(with: FilterType.issueFilters)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.refresh()
    }
}

extension IssuesViewController: UISearchBarDelegate {
    
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
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
//        view.addSubview(customNavBar)
        view.addSubview(tableView)
    }

    func activateConstraints() {
//        let navBarHeight: CGFloat = 30
        
//        customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        customNavBar.topAnchor.constraint(equalTo: navigationController!.topAnchor).isActive = true
//        customNavBar.heightAnchor.constraint(equalToConstant: navBarHeight).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureNavBar() {
        switch presenter.type {
        case .issue: title = "Issues"
        case .pullRequest: title = "Pull Requests"
        case .discussions: title = "Discussions"
        }
        
//        navigationController?.navigationBar.borderWidth = 0.0
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
