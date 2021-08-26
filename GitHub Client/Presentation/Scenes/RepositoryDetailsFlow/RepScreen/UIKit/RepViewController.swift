//
//  RepViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class RepViewController: UIViewController {
    
    private var viewModel: RepViewModel!

    static func create(with viewModel: RepViewModel) -> RepViewController {
        let viewController = RepViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private let adapter: RepositoryAdapter = RepositoryAdapterImpl()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = adapter
        tableView.refreshControl = refreshControl
        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(tableView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func refresh() {
        viewModel.refresh()
    }
}

// MARK: - Bind
private extension RepViewController {
    func bind(to viewModel: RepViewModel) {
        viewModel.title.observe(on: self) { [weak self] in self?.updateTitle($0) }
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateTitle(_ title: String) {
        self.title = title
    }

    func updateState(_ newState: RepositoryScreenState) {
        switch newState {
        case .loaded(let repository):
            prepareLoadedState(with: repository)
        case .loading:
            prepareLoadingState()
        case .error(let error):
            prepareErrorState(with: error)
        }
    }

    func prepareLoadedState(with repository: RepositoryDetails) {
        hideLoader()
        hideError()
        tableView.isHidden = false
        refreshControl.endRefreshing()
        adapter.update(repository)
        tableView.reloadData()
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
}

// MARK: - UITableViewDelegate
extension RepViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: viewModel.showBranches()
            case 1: viewModel.showCommits()
            case 2: viewModel.showSources()
            default: break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0: viewModel.showIssues()
            case 1: viewModel.showPullRequests()
            case 2: viewModel.showReleases()
            case 3: viewModel.showLicense()
            case 4: viewModel.showWatchers()
            default: break
            }
        }
    }

}

// MARK: - RepositoryHeaderTableViewCellDelegate
extension RepViewController: RepositoryHeaderTableViewCellDelegate {
    func starsButtonTapped() {
        viewModel.showStargazers()
    }

    func forksButtonTapped() {
        viewModel.showForks()
    }

    func starButtonTapped() {
        viewModel.addToStarred()
    }

    func subscribeButtonTapped() {
        viewModel.subscribe()
    }
}

// MARK: - setup views
private extension RepViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
