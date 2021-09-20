//
//  UsersListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

final class UsersListViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: UsersViewModel) -> UsersListViewController {
        let viewController = UsersListViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var collectionView: CollectionView = {
        let collectionView = CollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.dataSource = adapter
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        return collectionView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Private variables

    private var viewModel: UsersViewModel!
    private let cellManager = CollectionCellManager.create(cellType: UserCell.self)
    private lazy var adapter: CollectionViewAdapter = {
        CollectionViewAdapterImpl(with: cellManager)
    }()
    private var items: [User] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(collectionView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    @objc func refresh() {
        viewModel.refresh()
    }
}

// MARK: - Binding
private extension UsersListViewController {
    func bind(to viewModel: UsersViewModel) {
        viewModel.title.observe(on: self) { [weak self] in self?.updateTitle($0) }
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateTitle(_ newTitle: String) {
        title = newTitle
    }

    func updateState(_ newState: ItemsSceneState<User>) {
        switch newState {
        case .loaded(let items, let paths):
            prepareLoadedState(items, paths: paths)
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            prepareLoadingState()
        case .loadingNext:
            collectionView.showBottomIndicator()
        case .refreshing:
            refreshControl.beginRefreshing()
        }
    }

    func prepareLoadedState(_ users: [User], paths: [IndexPath]) {
        collectionView.isHidden = false
        self.items = users
        refreshControl.endRefreshing()
        collectionView.hideBottomIndicator()
        hideLoader()
        hideError()
        adapter.update(users)
        collectionView.insertItems(at: paths)
    }

    func prepareErrorState(with error: Error) {
        collectionView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.reload)
    }

    func prepareLoadingState() {
        collectionView.isHidden = true
        hideError()
        showLoader()
    }
}

// MARK: - UICollectionViewDelegate
extension UsersListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == items.count - 1 {
            viewModel.loadNext()
        }
    }
}

// MARK: - Setup Views
private extension UsersListViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
