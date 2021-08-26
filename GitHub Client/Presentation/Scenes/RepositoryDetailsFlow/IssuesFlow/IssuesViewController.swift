//
//  IssuesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

final class IssuesViewController: UIViewController {

    static func create(with viewModel: IssuesViewModel) -> IssuesViewController {
        let viewController = IssuesViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var adapter: IssuesAdapter = {
        IssuesAdapterImpl(cellManager: cellManager)
    }()

    private var viewModel: IssuesViewModel!
    private let cellManager = CollectionCellManager.create(cellType: IssueItemCell.self)

    private lazy var factory = CompositionalLayoutFactory()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: factory.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = adapter
        return collectionView
    }()

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
private extension IssuesViewController {
    func bind(to viewModel: IssuesViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.updateState($0) }
    }

    func updateState(_ newState: ItemsSceneState<Issue>) {
        switch newState {
        case .error(let error):
            prepareErrorState(error)
        case .loading:
            prepareLoadingState()
        case .loaded(let items):
            prepareLoadedState(items)
        }
    }

    func prepareLoadingState() {
        collectionView.isHidden = true
        hideError()
        showLoader()
    }

    func prepareLoadedState(_ issues: [Issue]) {
        hideLoader()
        hideError()
        collectionView.isHidden = false
        adapter.update(issues)
        collectionView.reloadData()
    }

    func prepareErrorState(_ error: Error) {
        collectionView.isHidden = true
        hideLoader()
        showError(error, reloadCompletion: viewModel.refresh)
    }
}

// MARK: - UICollectionViewDelegate
extension IssuesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

// MARK: - Setup Views
private extension IssuesViewController {
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
