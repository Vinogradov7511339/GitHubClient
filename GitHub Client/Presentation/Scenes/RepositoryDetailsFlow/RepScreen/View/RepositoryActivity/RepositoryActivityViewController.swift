//
//  RepositoryActivityViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit

final class RepositoryActivityViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: RepViewModel) -> RepositoryActivityViewController {
        let viewController = RepositoryActivityViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = adapter
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: RepViewModel!
    private lazy var adapter: RepositoryActivityAdapter = {
        RepositoryActivityAdapterImpl()
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
private extension RepositoryActivityViewController {
    func bind(to viewModel: RepViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: RepositoryScreenState) {
        switch newState {
        case .error(let error):
            prepareErrorState(error: error)
        case .loaded(let repository):
            prepareLoadedView(with: repository)
        case .loading:
            prepareLoadingState()
        }
    }

    func prepareLoadingState() {
        tableView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareLoadedView(with rep: RepositoryDetails) {
        tableView.isHidden = false
        hideError()
        hideLoader()
        adapter.update(rep)
        tableView.reloadData()
    }

    func prepareErrorState(error: Error) {
        tableView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }
}

// MARK: - UITableViewDelegate
extension RepositoryActivityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionType = RepositoryActivitySectionType(rawValue: indexPath.section)
        switch sectionType {
        case .actions:
            handleActionTap(at: indexPath.row)
        case .activity:
            break
        default:
            break
        }
    }

    func handleActionTap(at index: Int) {
        let rowType = RepositoryActionsRowType(rawValue: index)
        switch rowType {
        case .sources:
            viewModel.showSources()
        case .commits:
            viewModel.showCommits()
        case .branches:
            viewModel.showBranches()
        case .issues:
            viewModel.showIssues()
        case .pullRequests:
            viewModel.showPullRequests()
        case .releases:
            viewModel.showReleases()
        default:
            break
        }
    }
}

// MARK: - Setup views
private extension RepositoryActivityViewController {
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
