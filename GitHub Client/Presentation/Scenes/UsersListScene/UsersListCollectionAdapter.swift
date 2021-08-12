//
//  UsersListCollectionAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import UIKit

protocol UsersListAdapter: UICollectionViewDataSource {
    func update(_ users: [User])
}

final class UsersListAdapterImpl: NSObject {

    private var users: [User] = []
    private let cellManager: CollectionCellManager

    init(cellManager: CollectionCellManager) {
        self.cellManager = cellManager
    }

    func update(_ users: [User]) {
        self.users = users
    }
}

// MARK: - UsersListAdapter
extension UsersListAdapterImpl: UsersListAdapter {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = users[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: user)
        return cell
    }
}
