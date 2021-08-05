//
//  ItemsListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit
class ItemsListViewController<Item>: UIViewController,
                                                    UITableViewDelegate,
                                                    UITableViewDataSource,
                                                    UITableViewDataSourcePrefetching {

    private var viewModel: ItemsListViewModelImpl<Item>!

    static func create(with viewModel: ItemsListViewModelImpl<Item>) -> ItemsListViewController {
        let viewController = ItemsListViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let refreshControl = UIRefreshControl()
    private let cellManager = TableCellManager.create(cellType: UserTableViewCell.self)

    var nextPageLoadingSpinner: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)

        cellManager.register(tableView: tableView)

        title = viewModel.screenTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        viewModel.viewDidLoad()
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh()
    }

    private func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)
        return activityIndicator
    }

    private func showLoader() {
        print("loader")
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.items.value[indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }

    // MARK: - UITableViewDataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }
}

// MARK: - Binding
private extension ItemsListViewController {
    func bind(to viewModel: UsersListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateTableView() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0)}
    }

    func updateTableView() {
        tableView.reloadData()
    }

    func updateLoading(_ loading: UsersListViewModelLoading?) {
        switch loading {
        case .fullScreen:
            showLoader()
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = nextPageLoadingSpinner
        case .none:
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }

    func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showErrorAlert()
    }
}

// MARK: - setup views
private extension ItemsListViewController {
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
