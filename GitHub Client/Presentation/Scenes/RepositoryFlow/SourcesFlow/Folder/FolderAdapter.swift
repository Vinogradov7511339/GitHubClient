//
//  FolderAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import UIKit

protocol FolderAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ items: [FolderItem])
}

final class FolderAdapterImpl: NSObject {

    private let cellManager = TableCellManager.create(cellType: FolderCell.self)
    private var items: [FolderItem] = []
}

// MARK: - FolderAdapter
extension FolderAdapterImpl: FolderAdapter {
    func register(_ tableView: UITableView) {
        cellManager.register(tableView: tableView)
    }

    func update(_ items: [FolderItem]) {
        self.items = items
    }
}

// MARK: - UITableViewDataSource
extension FolderAdapterImpl {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: item)
        return cell
    }
}
