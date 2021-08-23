//
//  ResultsAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import UIKit

protocol ResultsAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ resultType: SearchResultType)
}

final class ResultsAdapterImpl: NSObject {

    private var resultType: SearchResultType = .empty
    private let repCellManager = TableCellManager.create(cellType: SearchRepCell.self)
    private let usersCellManager = TableCellManager.create(cellType: ResultUserCell.self)
    private let issuesCellManager = TableCellManager.create(cellType: ResultIssueCell.self)
    private let resultsCellManager = TableCellManager.create(cellType: ResultTotalCell.self)
}

// MARK: - ResultsAdapter
extension ResultsAdapterImpl: ResultsAdapter {
    func register(_ tableView: UITableView) {
        repCellManager.register(tableView: tableView)
        usersCellManager.register(tableView: tableView)
        issuesCellManager.register(tableView: tableView)
        resultsCellManager.register(tableView: tableView)
    }

    func update(_ resultType: SearchResultType) {
        self.resultType = resultType
    }
}

// MARK: - UITableViewDataSource
extension ResultsAdapterImpl {

    func numberOfSections(in tableView: UITableView) -> Int {
        switch resultType {
        case .all(_, _, _): return 3
        case .issues(_): return 1
        case .repList(_): return 1
        case .users(_): return 1
        case .empty: return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch resultType {
        case .empty: return 0
        case .repList(let repList): return repList.items.count
        case .users(let userList): return userList.items.count
        case .issues(let issueList): return issueList.items.count
        case .all(let repList, let issues, let users):
            if section == 0 { return repList.items.count + 1 }
            if section == 1 { return issues.items.count + 1 }
            if section == 2 { return users.items.count + 1 }
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch resultType {
        case .repList(let repList):
            let item = repList.items[indexPath.row]
            let cell = repCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: item)
            return cell

        case .issues(let issues):
            let item = issues.items[indexPath.row]
            let cell = issuesCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: item)
            return cell

        case .users(let users):
            let item = users.items[indexPath.row]
            let cell = usersCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: item)
            return cell

        case .all(let repList, let issues, let users):
            if indexPath.section == 0 {
                if indexPath.row < repList.items.count {
                    let item = repList.items[indexPath.row]
                    let cell = repCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
                    cell.populate(viewModel: item)
                    return cell
                } else {
                    let model = ResultTotalViewModel(type: .repList, totalCount: repList.total)
                    let cell = resultsCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
                    cell.populate(viewModel: model)
                    return cell
                }
            }
            if indexPath.section == 1 {
                if indexPath.row < issues.items.count {
                    let item = issues.items[indexPath.row]
                    let cell = issuesCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
                    cell.populate(viewModel: item)
                    return cell
                } else {
                    let model = ResultTotalViewModel(type: .issues, totalCount: issues.total)
                    let cell = resultsCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
                    cell.populate(viewModel: model)
                    return cell
                }
            }
            if indexPath.section == 2 {
                if indexPath.row < users.items.count {
                    let item = users.items[indexPath.row]
                    let cell = usersCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
                    cell.populate(viewModel: item)
                    return cell
                } else {
                    let model = ResultTotalViewModel(type: .users, totalCount: users.total)
                    let cell = resultsCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
                    cell.populate(viewModel: model)
                    return cell
                }
            }
            return UITableViewCell()
        case .empty:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch resultType {
        case .empty:
            return nil
        case .repList(_):
            return NSLocalizedString("Repositories", comment: "")
        case .issues(_):
            return NSLocalizedString("Issues", comment: "")
        case .users(_):
            return NSLocalizedString("Users", comment: "")
        case .all(_, _, _):
            if section == 0 {
                return NSLocalizedString("Repositories", comment: "")
            }
            if section == 1 {
                return NSLocalizedString("Issues", comment: "")
            }
            if section == 2 {
                return NSLocalizedString("Users", comment: "")
            }
            return nil
        }
    }
}
