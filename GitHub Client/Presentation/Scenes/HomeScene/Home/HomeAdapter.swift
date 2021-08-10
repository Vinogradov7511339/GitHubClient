//
//  HomeAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import UIKit

enum HomeMenuItems: Int, CaseIterable {

    case issues
    case pullRequests
    case discussions
    case repositories
    case organizations

    var viewModel: BaseDetailsCellViewModel {
        switch self {
        case .issues: return .issue
        case .pullRequests: return .pullRequests
        case .discussions: return .discussions
        case .repositories: return .repositories
        case .organizations: return .organizations
        }
    }
}

protocol HomeAdapter {
    var favorites: [Repository] { get set }

    func register(tableView: UITableView)
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRow(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

final class HomeAdapterImpl {

    enum SectionType: Int, CaseIterable {
        case menu, favorites
    }

    var favorites: [Repository]

    init(favorites: [Repository] = []) {
        self.favorites = favorites
    }
}

// MARK: - HomeAdapter
extension HomeAdapterImpl: HomeAdapter {
    func register(tableView: UITableView) {
        for cellManager in Self.dataViewMap.values {
            cellManager.register(tableView: tableView)
        }
    }

    func numberOfSections() -> Int {
        SectionType.allCases.count
    }

    func numberOfRows(in section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else {
            return 0
        }
        switch sectionType {
        case .menu:
            return HomeMenuItems.allCases.count
        case .favorites:
            return favorites.count
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

private extension HomeAdapterImpl {
    func viewModel(for indexPath: IndexPath) -> Any? {
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            return nil
        }
        switch sectionType {
        case .menu:
            return HomeMenuItems(rawValue: indexPath.row)?.viewModel
        case .favorites:
            return FavoriteRepositoryCellViewModel(repository: favorites[indexPath.row])
        }
    }

    func cellManager(for viewModel: Any) -> TableCellManager? {
        let key = "\(type(of: viewModel))"
        let cellManager = Self.dataViewMap[key]
        return cellManager
    }
}

// MARK: - Constants
private extension HomeAdapterImpl {
    static let dataViewMap: [String: TableCellManager] = [
        "\(BaseDetailsCellViewModel.self)": TableCellManager.create(cellType: BaseDetailsCell.self),
        "\(FavoriteRepositoryCellViewModel.self)":
            TableCellManager.create(cellType: FavoriteRepositoryTableViewCell.self)
    ]
}
