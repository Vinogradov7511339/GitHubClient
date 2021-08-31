//
//  UserProfileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class UserProfileViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: UserProfileViewModel) -> UserProfileViewController {
        let viewController = UserProfileViewController()
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

    // MARK: - Private variables

    private var viewModel: UserProfileViewModel!
    private lazy var adapter: UserAdapter = {
        UserAdapterImpl()
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
}

// MARK: - Actions
extension UserProfileViewController {
    @objc func share() {
        viewModel.share()
    }
}

// MARK: - Binding
private extension UserProfileViewController {
    func bind(to viewModel: UserProfileViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: UserScreenState) {
        switch newState {
        case .loading:
            prepareLoadingState()
        case .error(let error):
            prepareErrorState(with: error)
        case .loaded(let profile):
            prepareLoadedState(profile)
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

    func prepareLoadedState(_ profile: UserProfile) {
        tableView.isHidden = false
        hideLoader()
        hideError()
        adapter.update(profile)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - setup views
private extension UserProfileViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }

    func activateConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func configureNavBar() {
        title = NSLocalizedString("Profile", comment: "")
        let share = UIBarButtonItem(barButtonSystemItem: .action,
                                    target: self,
                                    action: #selector(share))
        navigationItem.rightBarButtonItem = share
    }
}
