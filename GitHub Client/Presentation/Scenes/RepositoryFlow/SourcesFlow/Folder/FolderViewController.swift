//
//  FolderViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

final class FolderViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: FolderViewModel) -> FolderViewController {
        let viewController = FolderViewController()
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
        tableView.delegate = self
        return tableView
    }()

    private lazy var errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Private variables

    private var viewModel: FolderViewModel!

    private lazy var adapter: FolderAdapter = {
        let adapter = FolderAdapterImpl()
        return adapter
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
private extension FolderViewController {
    func bind(to viewModel: FolderViewModel) {
        viewModel.title.observe(on: self) { [weak self] in self?.updateTitle($0) }
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateTitle(_ title: String) {
        self.title = title
    }

    func updateState(_ newState: FolderScreenState) {
        switch newState {
        case .loaded(let items):
            prepareLoadedState(with: items)
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            showLoader()
            tableView.isHidden = true
        }
    }

    private func prepareLoadedState(with items: [FolderItem]) {
        tableView.isHidden = false
        hideLoader()
        adapter.update(items)
        tableView.reloadData()
    }

    private func prepareErrorState(with error: Error) {
        tableView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }
}

// MARK: - UITableViewDelegate
extension FolderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - Setup views
private extension FolderViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
