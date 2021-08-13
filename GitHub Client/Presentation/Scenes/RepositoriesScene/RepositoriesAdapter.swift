//
//  RepositoriesAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

protocol RepositoriesAdapter: UICollectionViewDataSource {
    func update(_ users: [Repository])
}

final class RepositoriesAdapterImpl: NSObject {

    private var repositories: [Repository] = []
    private let cellManager: CollectionCellManager

    init(cellManager: CollectionCellManager) {
        self.cellManager = cellManager
    }

    func update(_ repositories: [Repository]) {
        self.repositories = repositories
    }
}

// MARK: - UsersListAdapter
extension RepositoriesAdapterImpl: RepositoriesAdapter {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        repositories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = repositories[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: user)
        return cell
    }
}

