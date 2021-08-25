//
//  MyUsersAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

protocol MyUsersAdapter: UICollectionViewDataSource {
    func register(_ collectionView: UICollectionView)
    func update(_ users: [User])
}

final class MyUsersAdapterImpl: NSObject {

    private var users: [User] = []
    private let cellManager = CollectionCellManager.create(cellType: UserCell.self)
}

// MARK: - MyRepositoriesAdapter
extension MyUsersAdapterImpl: MyUsersAdapter {

    func update(_ users: [User]) {
        self.users = users
    }

    func register(_ collectionView: UICollectionView) {
        cellManager.register(collectionView: collectionView)
    }
}

// MARK: - UICollectionViewDataSource
extension MyUsersAdapterImpl {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = users[indexPath.row]
        let cell = cellManager.dequeueReusableCell(collectionView: collectionView, for: indexPath)
        cell.populate(viewModel: user)
        return cell
    }
}

