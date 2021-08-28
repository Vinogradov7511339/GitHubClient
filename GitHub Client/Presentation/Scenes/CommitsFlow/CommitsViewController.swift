//
//  CommitsViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

final class CommitsViewController: UIViewController {

    // MARK: - Create
    static func create(with viewModel: CommitsViewModel) -> CommitsViewController {
        let viewController = CommitsViewController()
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
        collectionView.delegate = self
        collectionView.dataSource = adapter
        return collectionView
    }()

    // MARK: - Private variables

    private lazy var adapter: CollectionViewAdapter = {
        CollectionViewAdapterImpl(with: cellManager)
    }()

    private var viewModel: CommitsViewModel!
    private let cellManager = CollectionCellManager.create(cellType: CommitCell.self)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        activateConstraints()
        cellManager.register(collectionView: collectionView)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

// MARK: - Binding
private extension CommitsViewController {
    func bind(to viewModel: CommitsViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0)}
    }

    func updateState(_ newState: ItemsSceneState<ExtendedCommit>) {
        switch newState {
        case .loaded(let items):
            prepareLoadedState(items)
        case .loading:
            prepareLoadingState()
        case .error(let error):
            prepareErrorState(with: error)
        }
    }

    func prepareLoadedState(_ commits: [ExtendedCommit]) {
        hideLoader()
        hideError()
        collectionView.isHidden = false
        adapter.update(commits)
        collectionView.reloadData()
    }

    func prepareLoadingState() {
        collectionView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareErrorState(with error: Error) {
        collectionView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }
}

// MARK: - UICollectionViewDelegate
extension CommitsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - Setup Views
private extension CommitsViewController {
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


