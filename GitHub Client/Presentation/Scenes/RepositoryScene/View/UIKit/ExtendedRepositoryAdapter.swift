//
//  ExtendedRepositoryAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol ExtendedRepositoryAdapter {
    func register(tableView: UITableView)
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRow(in tableViw: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

final class ExtendedRepositoryAdapterImpl {

    enum Sections: Int, CaseIterable {
        case header, items, code, readme
    }

    enum ItemTypes: Int, CaseIterable {
        case issues, pullRequests, releases, watchers, license
    }

    enum CodeTypes: Int, CaseIterable {
        case code, commits
    }

    private let repository: Repository
    private let dataViewMap: [String: TableCellManager] = [
        "\(RepositoryDetailsHeaderCellViewModel.self)": TableCellManager.create(cellType: RepositoryHeaderTableViewCell.self),
        "\(TableCellViewModel.self)": TableCellManager.create(cellType: TableViewCell.self),
        "\(ReadMeCellViewModel.self)": TableCellManager.create(cellType: ReadMeTableViewCell.self),
    ]

    init(repository: Repository) {
        self.repository = repository
    }
}

// MARK: - ExtendedRepositoryFactory
extension ExtendedRepositoryAdapterImpl: ExtendedRepositoryAdapter {
    func register(tableView: UITableView) {
        for manager in dataViewMap.values {
            manager.register(tableView: tableView)
        }
    }

    func numberOfSections() -> Int {
        Sections.allCases.count
    }

    func numberOfRows(in section: Int) -> Int {
        let sectionType = Sections(rawValue: section)
        switch sectionType {
        case .header:
            return 1
        case .items:
            return ItemTypes.allCases.count
        case .code:
            return CodeTypes.allCases.count
        case .readme:
            return 1
        case .none:
            return 0
        }
    }

    func cellForRow(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel(for: indexPath) else {
            assert(false, "viewModel is empty at \(indexPath)")
            return UITableViewCell()
        }
        guard let cellManager = cellManager(for: viewModel) else {
            assert(false, "unknown viewModel \(viewModel) at \(indexPath)")
            return UITableViewCell()
        }
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }
}

private extension ExtendedRepositoryAdapterImpl {

    func viewModel(for indexPath: IndexPath) -> Any? {
        guard let sectionType = Sections(rawValue: indexPath.section) else {
            return nil
        }
        switch sectionType {
        case .header:
            return RepositoryDetailsHeaderCellViewModel(repository: repository)
        case .items:
            if let itemType = ItemTypes(rawValue: indexPath.row) {
                return viewModel(for: itemType)
            } else {
                return nil
            }
        case .code:
            if let codeType = CodeTypes(rawValue: indexPath.row) {
                return  viewModel(for: codeType)
            } else {
                return nil
            }
        case .readme:
            return ReadMeCellViewModel(mdText: "### Read me!!!")
        }
    }

    func viewModel(for itemType: ItemTypes) -> TableCellViewModel {
        switch itemType {
        case .issues:
            return TableCellViewModel(text: "Issues")
        case .pullRequests:
            return TableCellViewModel(text: "Pull Requests")
        case .releases:
            return TableCellViewModel(text: "Releases")
        case .watchers:
            return TableCellViewModel(text: "Watchers")
        case .license:
            return TableCellViewModel(text: "License")
        }
    }

    func viewModel(for codeType: CodeTypes) -> TableCellViewModel {
        switch codeType {
        case .code:
            return TableCellViewModel(text: "Code")
        case .commits:
            return TableCellViewModel(text: "Commits")
        }
    }

    func cellManager(for viewModel: Any) -> TableCellManager? {
        let key = "\(type(of: viewModel))"
        let cellManager = dataViewMap[key]
        return cellManager
    }
}
