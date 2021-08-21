//
//  MyRepositoriesAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

protocol MyRepositoriesAdapter: UICollectionViewDataSource {
    func register(_ collectionView: UICollectionView)
    func update(_ repositories: [Repository])
}

final class MyRepositoriesAdapterImpl: NSObject {

    private var repositories: [Repository] = []
    private let cellManager = CollectionCellManager.create(cellType: RepositoryItemCell.self)
}

// MARK: - MyRepositoriesAdapter
extension MyRepositoriesAdapterImpl: MyRepositoriesAdapter {

    func update(_ repositories: [Repository]) {
        self.repositories = repositories
    }

    func register(_ collectionView: UICollectionView) {
        cellManager.register(collectionView: collectionView)
    }
}

// MARK: - UICollectionViewDataSource
extension MyRepositoriesAdapterImpl {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        repositories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = repositories[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: user)
        return cell
    }
}
