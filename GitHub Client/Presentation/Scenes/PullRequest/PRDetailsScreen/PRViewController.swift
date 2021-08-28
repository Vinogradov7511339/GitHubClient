//
//  PRViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

final class PRViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: PRViewModel) -> PRViewController {
        let viewController = PRViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.dataSource = adapter
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: PRViewModel!
    private lazy var adapter: PRAdapter = {
        PRAdapterImpl()
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
private extension PRViewController {
    func bind(to viewModel: PRViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: PRScreenState) {
        switch newState {
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            prepareLoadingState()
        case .loaded(let model, let comments):
            prepareLoadedState(model, comments: comments)
        }
    }

    func prepareLoadingState() {
        tableView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareErrorState(with error: Error) {
        tableView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }

    func prepareLoadedState(_ model: PullRequestDetails, comments: [Comment]) {
        tableView.isHidden = false
        hideError()
        hideLoader()
        adapter.update(with: model, comments: comments)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension PRViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sectionType = PRSectionType(rawValue: indexPath.section) else { return }
        switch sectionType {
        case .prInfo:
            didSelect(indexPath.row)
        case .comment: break
        }
    }

    private func didSelect(_ row: Int) {
        guard let rowType = PRHeaderCellType(rawValue: row) else { return }
        switch rowType {
        case .header: break
        case .headerComment: break
        case .diffCell: viewModel.showDiff()
        case .commits: viewModel.showCommits()
        }
    }
}

// MARK: - Setup views
private extension PRViewController {
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
