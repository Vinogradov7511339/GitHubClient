//
//  PRListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

final class PRListViewController: UIViewController {

    // MARK: - Create

    static func create(with viewModel: PRListViewModel) -> PRListViewController {
        let viewController = PRListViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Views

    private lazy var collectionView: UICollectionView = {
        let layoutFactory = CompositionalLayoutFactory()
        let layout = layoutFactory.layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.dataSource = adapter
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - Private variables

    private var viewModel: PRListViewModel!
    private let cellManager = CollectionCellManager.create(cellType: PullRequestItemCell.self)
    private lazy var adapter: CollectionViewAdapter = {
        CollectionViewAdapterImpl(with: cellManager)
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()

        adapter.register(collectionView)
        title = NSLocalizedString("Pull Requests", comment: "")

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension PRListViewController {
    func bind(to viewModel: PRListViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: ItemsSceneState<PullRequest>) {
        switch newState {
        case .loaded(let items):
            prepareLoadedState(with: items)
        case .error(let error):
            prepareErrorState(with: error)
        case .loading:
            prepareLoadingState()
        }
    }

    func prepareLoadedState(with items: [PullRequest]) {
        collectionView.isHidden = false
        hideError()
        hideLoader()
        adapter.update(items)
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
extension PRListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - Setup views
private extension PRListViewController {
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
