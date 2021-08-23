//
//  ResultsAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

enum ResultsAdapterType {
    case empty
    case repList([Repository])
    case userList([User])
}

protocol ResultsAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ type: ResultsAdapterType)
}

final class ResultsAdapterImpl: NSObject {

    private var type: ResultsAdapterType = .empty
    private let repCellManager = TableCellManager.create(cellType: SearchRepCell.self)
    private let usersCellManager = TableCellManager.create(cellType: SearchRepCell.self)
}

// MARK: - ResultsAdapter
extension ResultsAdapterImpl: ResultsAdapter {
    func register(_ tableView: UITableView) {
        repCellManager.register(tableView: tableView)
        usersCellManager.register(tableView: tableView)
    }

    func update(_ type: ResultsAdapterType) {
        self.type = type
    }
}

// MARK: - UITableViewDataSource
extension ResultsAdapterImpl {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .empty: return 0
        case .repList(let repList): return repList.count
        case .userList(let users): return users.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .repList(let repList):
            let item = repList[indexPath.row]
            let cell = repCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: item)
            return cell
        case .userList(let users):
            let item = users[indexPath.row]
            let cell = repCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: item)
            return cell
        case .empty:
            return UITableViewCell()
        }
    }
}
