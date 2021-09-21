//
//  RepositoryInfoViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit

final class RepositoryInfoViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: RepViewModel) -> RepositoryInfoViewController {
        let viewController = RepositoryInfoViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = adapter
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: RepViewModel!
    private lazy var adapter: RepositoryInfoAdapter = {
        RepositoryInfoAdapterImpl()
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
private extension RepositoryInfoViewController {
    func bind(to viewModel: RepViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: DetailsScreenState<RepositoryDetails>) {
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
extension RepositoryInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionType = adapter.visibleSectionTypes[indexPath.section]
        switch sectionType {
        case .owner:
            viewModel.showOwner()
        case .popularity:
            showItem(row: indexPath.row)
        case .license:
            viewModel.showLicense()
        default:
            break
        }
    }

    func showItem(row: Int) {
        guard let itemType = RepositoryInfoRowType(rawValue: row) else { return }
        switch itemType {
        case .contributors:
            viewModel.showContributors()
        case .forks:
            viewModel.showForks()
        case .stargazers:
            viewModel.showStargazers()
        case .subscribers:
            viewModel.showSubscribers()
        }
    }
}

// MARK: - Setup views
private extension RepositoryInfoViewController {
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
