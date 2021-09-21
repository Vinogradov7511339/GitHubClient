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
    var visibleSectionTypes: [RepositoryInfoSectionType] { get }

    func register(_ tableView: UITableView)
    func update(_ repository: RepositoryDetails)
}

final class RepositoryInfoAdapterImpl: NSObject {
    var visibleSectionTypes: [RepositoryInfoSectionType] = []
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
        self.visibleSectionTypes = repository.sections
    }
}

// MARK: - UITableViewDataSource
extension RepositoryInfoAdapterImpl {
    func numberOfSections(in tableView: UITableView) -> Int {
        visibleSectionTypes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        visibleSectionTypes[section].numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = visibleSectionTypes[indexPath.section]
        guard let cellManager = cellManagers[sectionType] else { return UITableViewCell() }
        guard let viewModel = viewModel(for: indexPath) else { return UITableViewCell() }
        let cell = cellManager.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell.populate(viewModel: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        visibleSectionTypes[section].title
    }

    func viewModel(for indexPath: IndexPath) -> Any? {
        let sectionType = visibleSectionTypes[indexPath.section]
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

private extension RepositoryDetails {
    var sections: [RepositoryInfoSectionType] {
        var sections: [RepositoryInfoSectionType] = []
        sections.append(.owner)
        if repository.description != nil {
            sections.append(.description)
        }
        sections.append(.popularity)
        if repository.license != nil {
            sections.append(.license)
        }
        if mdText != nil {
            sections.append(.readMe)
        }
        return sections
    }
}
