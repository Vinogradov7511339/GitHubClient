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
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = adapter
        return tableView
    }()

    // MARK: - Private variables

    private var viewModel: UserProfileViewModel!
    private lazy var adapter: UserAdapter = {
        UserAdapterImpl(headerDelegate: self)
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

    @objc func followButtonTapped() {
        viewModel.follow()
    }
}

// MARK: - Binding
private extension UserProfileViewController {
    func bind(to viewModel: UserProfileViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: DetailsScreenState<UserProfile>) {
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
        configureNavBar(profile.isFollowed)
        hideLoader()
        hideError()
        adapter.update(profile)
        tableView.reloadData()
    }
}

// MARK: - UserHeaderCellDelegate
extension UserProfileViewController: UserHeaderCellDelegate {
    func followersButtonTapped() {
        viewModel.showFollowers()
    }

    func followingButtonTapped() {
        viewModel.showFollowing()
    }
}

// MARK: - UITableViewDelegate
extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionType = adapter.visibleSectionTypes[indexPath.section]
        switch sectionType {
        case .actions:
            openAction(at: indexPath.row)
        default:
            break
        }
    }

    func openAction(at index: Int) {
        let rowType = adapter.visibleRows[index]
        switch rowType {
        case .repositories:
            viewModel.showRepositories()
        case .starred:
            viewModel.showStarred()
        case .gists:
            viewModel.showGists()
        case .events:
            viewModel.showEvents()
        }
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

    func configureNavBar(_ followed: Bool? = nil) {
        title = NSLocalizedString("Profile", comment: "")
        var buttons: [UIBarButtonItem] = []
        buttons.append(shareButton())
        if let followed = followed {
            buttons.append(followButton(followed))
        }
        navigationItem.rightBarButtonItems = buttons
    }

    func shareButton() -> UIBarButtonItem {
        UIBarButtonItem(barButtonSystemItem: .action,
                        target: self,
                        action: #selector(share))
    }

    func followButton(_ followed: Bool) -> UIBarButtonItem {
        let image: UIImage? = followed ? UIImage.UserProfile.unfollow : UIImage.UserProfile.follow
        return  UIBarButtonItem(image: image,
                                style: .plain,
                                target: self,
                                action: #selector(followButtonTapped))
    }
}
