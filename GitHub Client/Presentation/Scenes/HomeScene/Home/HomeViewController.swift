//
//  MyWorkViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!

    static func create(with viewModel: HomeViewModel) -> HomeViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
//    private lazy var resultViewController: SearchResultViewController = {
////        fatalError()
////        let resultController = SearchConfigurator.createModule()
////        return resultController
//    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search GitHub"
        searchController.isActive = true
        return searchController
    }()
    
    private let refreshControl = UIRefreshControl()
    
//    private let dataViewMap: [String: TableCellManager] = [
//        "\(TableCellViewModel.self)": TableCellManager.create(cellType: TableViewCell.self),
//        "\(FavoritesEmptyCellViewModel.self)": TableCellManager.create(cellType: FavoritesEmptyTableViewCell.self),
//        "\(RecentEventsCellViewModel.self)": TableCellManager.create(cellType: RecentEventsTableViewCell.self)
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        activateConstraints()
        configureNavigationBar()

        viewModel.cellManager.register(tableView: tableView)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)

        observeToNotifications()

        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh()
    }

    private func observeToNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }
        notificationCenter.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }
    }
    
    private func handleKeyboard(notification: Notification) {
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            view.layoutIfNeeded()
            return
        }
        
        guard
            let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }

        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        self.searchController.showsSearchResultsController = keyboardHeight != 0
    }
}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
//        resultViewController.text = searchController.searchBar.text ?? ""
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return presenter?.header(for: section)
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return presenter?.heightForHeader(in: section) ?? 0.0
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return presenter?.heightForCell(at: indexPath) ?? 0.0
//    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.tableItems.value.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableItems.value[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.tableItems.value[indexPath.section][indexPath.row]
        let cell = viewModel.cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: item)
        return cell
    }
}

// MARK: - setup views
private extension HomeViewController {
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
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
}
