//
//  ForksViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 30.08.2021.
//

import UIKit

final class RepositoriesViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: RepositoriesViewModel) -> RepositoriesViewController {
        let viewController = RepositoriesViewController()
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
        return collectionView
    }()

    // MARK: - Private variables

    private var viewModel: RepositoriesViewModel!
    private let cellManager = CollectionCellManager.create(cellType: RepositoryItemCell.self)
    private lazy var adapter: CollectionViewAdapter = {
        CollectionViewAdapterImpl(with: cellManager)
    }()
    private var items: [Repository] = []

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
private extension RepositoriesViewController {
    func bind(to viewModel: RepositoriesViewModel) {
        viewModel.title.observe(on: self) { [weak self] in self?.updateTitle($0) }
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateTitle(_ newTitle: String) {
        self.title = newTitle
    }

    func updateState(_ newState: ItemsSceneState<Repository>) {
        switch newState {
        case .loading:
            prepareLoadingState()
        case .error(let error):
            prepareErrorState(with: error)
        case .loaded(let items, let paths):
            prepareLoadedState(items, paths: paths)
        case .loadingNext:
            break
        case .refreshing:
            break
        }
    }

    func prepareLoadingState() {
        collectionView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareErrorState(with error: Error) {
        collectionView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.reload)
    }

    func prepareLoadedState(_ items: [Repository], paths: [IndexPath]) {
        collectionView.isHidden = false
        self.items = items
        collectionView.hideBottomIndicator()
        hideLoader()
        hideError()
        adapter.update(items)
        collectionView.insertItems(at: paths)
    }
}

// MARK: - UICollectionViewDelegate
extension RepositoriesViewController: UICollectionViewDelegate {
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

// MARK: - Setup views
private extension RepositoriesViewController {
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
