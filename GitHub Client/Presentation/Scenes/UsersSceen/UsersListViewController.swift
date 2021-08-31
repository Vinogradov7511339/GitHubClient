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

    private lazy var collectionView: UICollectionView = {
        let factory = CompositionalLayoutFactory()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: factory.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        return collectionView
    }()

    // MARK: - Private variables

    private var viewModel: UsersViewModel!
    private let cellManager = CollectionCellManager.create(cellType: UserCell.self)
    private lazy var adapter: CollectionViewAdapter = {
        CollectionViewAdapterImpl(with: cellManager)
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(collectionView)

        bind(to: viewModel)
        viewModel.viewDidLoad()
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
        case .loaded(let items):
            prepareLoadedState(items)
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            prepareLoadingState()
        }
    }

    func prepareLoadedState(_ users: [User]) {
        collectionView.isHidden = false
        hideLoader()
        hideError()
        adapter.update(users)
        collectionView.reloadData()
    }

    func prepareErrorState(with error: Error) {
        collectionView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
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
