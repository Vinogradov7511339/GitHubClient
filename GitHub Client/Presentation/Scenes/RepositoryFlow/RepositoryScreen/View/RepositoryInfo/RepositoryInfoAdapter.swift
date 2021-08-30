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
    case stargazers
    case forks
    case license
    case readMe

    var title: String {
        switch self {
        case .owner:
            return NSLocalizedString("Owner", comment: "")
        case .description:
            return NSLocalizedString("Description", comment: "")
        case .stargazers:
            return NSLocalizedString("Stargazers", comment: "")
        case .forks:
            return NSLocalizedString("Forks", comment: "")
        case .license:
            return NSLocalizedString("License", comment: "")
        case .readMe:
            return NSLocalizedString("Read Me", comment: "")
        }
    }
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
        .stargazers: TableCellManager.create(cellType: RepositoryStargazersCell.self),
        .forks: TableCellManager.create(cellType: RepositoryForksCell.self),
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
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repository = repository else { return UITableViewCell() }

        let sectionType = RepositoryInfoSectionType(rawValue: indexPath.section)
        guard let sectionType = sectionType else { return UITableViewCell() }
        guard let cellManager = cellManagers[sectionType] else { return UITableViewCell() }

        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: repository)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        RepositoryInfoSectionType(rawValue: section)?.title
    }
}
