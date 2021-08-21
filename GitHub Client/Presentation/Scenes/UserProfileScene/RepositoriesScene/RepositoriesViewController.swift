//
//  RepositoriesViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

final class RepositoriesViewController: UIViewController {

    static func create(with viewModel: RepositoriesViewModel) -> RepositoriesViewController {
        let viewController = RepositoriesViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var adapter: RepositoriesAdapter = {
        RepositoriesAdapterImpl(cellManager: cellManager)
    }()

    private var viewModel: RepositoriesViewModel!
    private let cellManager = CollectionCellManager.create(cellType: RepositoryItemCell.self)

    private lazy var collectionView: UICollectionView = {
        let layoutFactory = CompositionalLayoutFactory()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFactory.layout)
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
private extension RepositoriesViewController {
    func bind(to viewModel: RepositoriesViewModel) {
        viewModel.title.observe(on: self) { [weak self] in self?.updateTitle($0) }
        viewModel.repositories.observe(on: self) { [weak self] in self?.updateItems($0)}
    }

    func updateTitle(_ title: String) {
        self.title = title
    }

    func updateItems(_ repositories: [Repository]) {
        adapter.update(repositories)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension RepositoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
}

extension RepositoriesViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .zero
//    }
}

// MARK: - Setup Views
private extension RepositoriesViewController {
    func setupViews() {
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
