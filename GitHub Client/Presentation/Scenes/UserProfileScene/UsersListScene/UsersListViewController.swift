//
//  UsersListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

final class UsersListViewController: UIViewController {

    static func create(with viewModel: UsersListViewModel) -> UsersListViewController {
        let viewController = UsersListViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    private lazy var adapter: UsersListAdapter = {
        UsersListAdapterImpl(cellManager: cellManager)
    }()

    private var viewModel: UsersListViewModel!
    private let cellManager = CollectionCellManager.create(cellType: UserCell.self)

    private lazy var collectionView: UICollectionView = {
        let factory = CompositionalLayoutFactory()
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
private extension UsersListViewController {
    func bind(to viewModel: UsersListViewModel) {
        viewModel.users.observe(on: self) { [weak self] in self?.updateItems($0)}
    }

    func updateItems(_ users: [User]) {
        adapter.update(users)
        collectionView.reloadData()
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
        view.addSubview(collectionView)
    }

    func activateConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
