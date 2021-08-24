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

    private let cellManagers: [SearchType: TableCellManager] = [
        .repositories: TableCellManager.create(cellType: SearchRepCell.self),
        .issues: TableCellManager.create(cellType: ResultIssueCell.self),
        .pullRequests: TableCellManager.create(cellType: ResultPullRequestCell.self),
        .people: TableCellManager.create(cellType: ResultUserCell.self),
    ]
    private let resultsCellManager = TableCellManager.create(cellType: ResultTotalCell.self)
}

// MARK: - ResultsAdapter
extension ResultsAdapterImpl: ResultsAdapter {
    func register(_ tableView: UITableView) {
        cellManagers.values.forEach { $0.register(tableView: tableView) }
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
        case .results(let resultModels): return resultModels.count
        case .empty: return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SearchType(rawValue: section) else {
            assert(false, "no section type")
            return 0
        }
        guard case .results(let resultModels) = resultType else {
            return 0
        }
        let items = resultModels[sectionType]?.items
        if let items = items {
            return items.count + 1 // +1 because adding all results cell
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SearchType(rawValue: indexPath.section) else {
            assert(false, "no section type")
            return UITableViewCell()
        }
        guard case .results(let resultModels) = resultType else {
            return UITableViewCell()
        }
        guard let model = resultModels[sectionType] else {
            return UITableViewCell()
        }
        guard let cellManager = cellManagers[sectionType] else {
            assert(false, "no cell manager")
            return UITableViewCell()
        }
        if indexPath.row < model.items.count {
            let item = model.items[indexPath.row]
            let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: item)
            return cell
        } else {
            let model = ResultTotalViewModel(type: sectionType, totalCount: model.total)
            let cell = resultsCellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
            cell.populate(viewModel: model)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType = SearchType(rawValue: section) else {
            assert(false, "no section type")
            return nil
        }
        return sectionType.title
    }
}
