//
//  RepositoryInfoAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 29.08.2021.
//

import UIKit

enum RepositoryInfoSectionType: Int, CaseIterable {
    case owner
    case description
    case popularity
    case license
    case readMe

    var numberOfRows: Int {
        switch self {
        case .owner: return 1
        case .description: return 1
        case .popularity: return RepositoryInfoRowType.allCases.count
        case .license: return 1
        case .readMe: return 1
        }
    }

    var title: String {
        switch self {
        case .owner:
            return NSLocalizedString("Owner", comment: "")
        case .description:
            return NSLocalizedString("Description", comment: "")
        case .popularity:
            return NSLocalizedString("Popularity", comment: "")
        case .license:
            return NSLocalizedString("License", comment: "")
        case .readMe:
            return NSLocalizedString("Read Me", comment: "")
        }
    }
}

enum RepositoryInfoRowType: Int, CaseIterable {
    case forks
    case stargazers
    case subscribers
    case contributors
}

protocol RepositoryInfoAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ repository: RepositoryDetails)
}

final class RepositoryInfoAdapterImpl: NSObject {
    private var repository: RepositoryDetails?
    private let cellManagers: [RepositoryInfoSectionType: TableCellManager] = [
        .owner: TableCellManager.create(cellType: RepositoryOwnerCell.self),
        .description: TableCellManager.create(cellType: RepositoryDescriptionCell.self),
        .popularity: TableCellManager.create(cellType: RepositoryPopularityCell.self),
        .license: TableCellManager.create(cellType: RepositoryLicenseCell.self),
        .readMe: TableCellManager.create(cellType: ReadMeCell.self)
    ]
}

// MARK: - RepositoryInfoAdapter
extension RepositoryInfoAdapterImpl: RepositoryInfoAdapter {
    func register(_ tableView: UITableView) {
        cellManagers.values.forEach { $0.register(tableView: tableView) }
    }

    func update(_ repository: RepositoryDetails) {
        self.repository = repository
    }
}

// MARK: - UITableViewDataSource
extension RepositoryInfoAdapterImpl {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard repository != nil else { return 0 }
        return RepositoryInfoSectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RepositoryInfoSectionType(rawValue: section)?.numberOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = RepositoryInfoSectionType(rawValue: indexPath.section)
        guard let sectionType = sectionType else { return UITableViewCell() }
        guard let cellManager = cellManagers[sectionType] else { return UITableViewCell() }
        guard let viewModel = viewModel(for: indexPath) else { return UITableViewCell() }
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        RepositoryInfoSectionType(rawValue: section)?.title
    }

    func viewModel(for indexPath: IndexPath) -> Any? {
        let sectionType = RepositoryInfoSectionType(rawValue: indexPath.section)
        guard let sectionType = sectionType else { return nil }
        switch sectionType {
        case .owner:
            return repository
        case .description:
            return repository
        case .popularity:
            return RepositoryInfoRowType(rawValue: indexPath.row)
        case .license:
            return repository
        case .readMe:
            return repository
        }
    }
}
