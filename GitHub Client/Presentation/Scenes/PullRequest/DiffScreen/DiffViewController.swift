//
//  DiffViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit
import TextCompiler

final class DiffViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: DiffViewModel) -> DiffViewController {
        let viewController = DiffViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.dataSource = adapter
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: DiffViewModel!
    private let cellManager = TableCellManager.create(cellType: DiffCell.self)
    private lazy var adapter: TableViewAdapter = {
        TableViewAdapterImpl(with: cellManager)
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension DiffViewController {
    func bind(to viewModel: DiffViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: ItemsSceneState<Diff>) {
        switch newState {
        case .loading:
            prepareLoadingState()
        case .error(let error):
            prepareErrorState(error)
        case .loaded(let commit):
            prepareLoadedState(commit)
        }
    }

    func prepareLoadingState() {
        tableView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareErrorState(_ error: Error) {
        tableView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }

    func prepareLoadedState(_ diffs: [Diff]) {
        tableView.isHidden = false
        hideLoader()
        hideError()
        adapter.update(diffs)
        tableView.reloadData()
    }
}

// MARK: - Setup views
private extension DiffViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
