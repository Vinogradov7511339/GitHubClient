//
//  CommitInfoViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

final class CommitInfoViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: CommitViewModel) -> CommitInfoViewController {
        let viewController = CommitInfoViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.dataSource = adapter
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: CommitViewModel!
    private lazy var adapter: CommitInfoAdapter = {
        CommitInfoAdapterImpl()
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(tableView)
        bind(to: viewModel)
    }
}

// MARK: - Binding
private extension CommitInfoViewController {
    func bind(to viewModel: CommitViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: CommitScreenState) {
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

    func prepareLoadedState(_ commit: Commit) {
        tableView.isHidden = false
        hideLoader()
        hideError()
        adapter.update(with: commit)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension CommitInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionType = CommitInfoSectionType(rawValue: indexPath.section)
        switch sectionType {
        case .author:
            viewModel.showAuthor()
        case .parentCommit:
            viewModel.showParentCommit()
        default:
            break
        }
    }
}

// MARK: - Setup views
private extension CommitInfoViewController {
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
