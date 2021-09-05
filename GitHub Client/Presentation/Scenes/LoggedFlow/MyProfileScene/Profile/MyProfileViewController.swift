//
//  ProfileViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

import UIKit

final class MyProfileViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: ProfileViewModel) -> MyProfileViewController {
        let viewController = MyProfileViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.dataSource = adapter
        tableView.delegate = self
        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Private variables

    private var viewModel: ProfileViewModel!
    private lazy var adapter: ProfileAdapter = {
        ProfileAdapterImpl(headerDelegate: self, activityCellDelegate: self)
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
extension MyProfileViewController {
    @objc func openSettings() {
        viewModel.openSettings()
    }

    @objc func refresh() {
        viewModel.refresh()
    }

    @objc func share() {
        viewModel.share()
    }
}

// MARK: - Binding
private extension MyProfileViewController {
    func bind(to viewModel: ProfileViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: MyProfileScreenState) {
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

    func prepareLoadedState(_ profile: AuthenticatedUser) {
        tableView.isHidden = false
        hideLoader()
        hideError()
        refreshControl.endRefreshing()
        adapter.update(with: profile)
        tableView.reloadData()
    }
}

// MARK: - ProfileHeaderCellDelegate
extension MyProfileViewController: ProfileHeaderCellDelegate {
    func followersButtonTapped() {
        viewModel.showFollowers()
    }

    func followingButtonTapped() {
        viewModel.showFollowing()
    }
}

// MARK: - MyProfileActivityCellDelegate
extension MyProfileViewController: MyProfileActivityCellDelegate {
    func linkTapped(_ url: URL) {
        viewModel.openLink(url)
    }
}

// MARK: - UITableViewDelegate
extension MyProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionType = MyProfileSectionTypes(rawValue: indexPath.section)
        switch sectionType {
        case .header:
            break
        case .actions:
            showItem(at: indexPath.row)
        default:
            break
        }
    }

    func showItem(at index: Int) {
        let rowType = MyProfileRowType(rawValue: index)
        switch rowType {
        case .repositories:
            viewModel.openRepositories()
        case .starred:
            viewModel.openStarred()
        case .subscriptions:
            viewModel.openSubscriptions()
        default:
            break
        }
    }
}

private extension MyProfileViewController {
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

    func configureNavBar() {
        let settings = UIBarButtonItem(image: UIImage(named: "icon_tabbar_settings"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(openSettings))
        let share = UIBarButtonItem(barButtonSystemItem: .action,
                                    target: self,
                                    action: #selector(share))
        navigationItem.setRightBarButtonItems([settings, share], animated: true)
    }
}
