//
//  BranchesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.08.2021.
//

import UIKit

final class BranchesViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: BranchesViewModel) -> BranchesViewController {
        let viewController = BranchesViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = adapter
        return tableView
    }()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()

    // MARK: - Private variables

    private var viewModel: BranchesViewModel!
    private let cellManager = TableCellManager.create(cellType: BranchCell.self)
    private lazy var adapter: TableViewAdapter = {
        TableViewAdapterImpl(with: cellManager)
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        configureNavBar()

        adapter.register(tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Actions

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Binding
private extension BranchesViewController {
    func bind(to viewModel: BranchesViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: ItemsSceneState<Branch>) {
        switch newState {
        case .loaded(let items, _):
            prepareLoadedState(items)
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            prepareLoadingState()
        case .loadingNext:
            break
        case .refreshing:
            break
        }
    }

    func prepareLoadedState(_ items: [Branch]) {
        tableView.isHidden = false
        hideError()
        hideLoader()
        adapter.update(items)
        tableView.reloadData()
    }

    func prepareErrorState(with error: Error) {
        tableView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.reload)
    }

    func prepareLoadingState() {
        tableView.isHidden = true
        hideError()
        showLoader()
    }
}

// MARK: - UITableViewDelegate
extension BranchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Setup views
private extension BranchesViewController {
    func setupViews() {
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

    func configureNavBar() {
        title = NSLocalizedString("Choose Branch", comment: "")
        navigationItem.searchController = searchController
        let close = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        navigationItem.setLeftBarButton(close, animated: true)
    }
}
