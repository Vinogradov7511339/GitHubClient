//
//  TableViewAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import UIKit

protocol TableViewAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ items: [Any])
}

final class TableViewAdapterImpl: NSObject {

    private let cellManager: TableCellManager
    private var items: [Any] = []

    init(with cellManager: TableCellManager) {
        self.cellManager = cellManager
    }
}

// MARK: - TableViewAdapter
extension TableViewAdapterImpl: TableViewAdapter {
    func register(_ tableView: UITableView) {
        cellManager.register(tableView: tableView)
    }

    func update(_ items: [Any]) {
        self.items = items
    }
}

// MARK: - UITableViewDataSource
extension TableViewAdapterImpl {
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
