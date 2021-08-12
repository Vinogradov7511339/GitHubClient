//
//  UsersListViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

final class UsersListViewController: UIViewController {

    class TempLayout: UICollectionViewFlowLayout {

        override func prepare() {
            super.prepare()
            guard let collectionView = collectionView else { return }

            let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
            let maxNumColumns = Int(availableWidth / 120.0)
            let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)

            self.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.5)

            let totalCellWidth = cellWidth * CGFloat(maxNumColumns)
            let totalSpacingWidth = 16.0 * CGFloat(maxNumColumns - 1)

            let leftInset = (availableWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset

            self.sectionInset = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
            self.sectionInsetReference = .fromSafeArea
        }
    }

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
//        let layout = adapter.layout
        let layout = TempLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
