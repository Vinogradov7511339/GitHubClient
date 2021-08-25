//
//  RepositoryAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 17.08.2021.
//

import UIKit

enum RepositoryRowType {
    case currentBranch
    case commits
    case sources
    case issues
    case pullRequests
    case releases
    case license
    case subscribers
}

protocol RepositoryAdapter: UITableViewDataSource {
    func register(_ tableView: UITableView)
    func update(_ repository: RepositoryDetails)
}

final class RepositoryAdapterImpl: NSObject, RepositoryAdapter{

    enum SectionTypes: Int, CaseIterable {
        case header
        case code
        case info
        case readMe
    }

    private let cellManages: [SectionTypes: TableCellManager] = [
        .header: TableCellManager.create(cellType: RepositoryHeaderTableViewCell.self),
        .info: TableCellManager.create(cellType: RepositoryInfoCell.self),
        .code: TableCellManager.create(cellType: RepositoryInfoCell.self),
        .readMe: TableCellManager.create(cellType: ReadMeTableViewCell.self)
    ]

    private var repository: RepositoryDetails?
}

// MARK: - RepositoryAdapter
extension RepositoryAdapterImpl {
    func register(_ tableView: UITableView) {
        cellManages.values.forEach { $0.register(tableView: tableView) }
    }

    func update(_ repository: RepositoryDetails) {
        self.repository = repository
    }
}

// MARK: - UITableViewDataSource
extension RepositoryAdapterImpl  {
    func numberOfSections(in tableView: UITableView) -> Int {
        SectionTypes.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionTypes(rawValue: indexPath.section) else {
            return BaseTableViewCell(frame: .zero)
        }
        guard let viewModel = viewModel(indexPath) else {
            assert(false, "Empty viewmodel")
            return BaseTableViewCell(frame: .zero)
        }

        let cellManager = cellManages[sectionType]
        let cell = cellManager?.dequeueReusableCell(tableView: tableView, for: indexPath)
        cell?.populate(viewModel: viewModel)
        return cell ?? BaseTableViewCell(frame: .zero)
    }
}

private extension RepositoryAdapterImpl {
    func numberOfRows(in section: Int) -> Int {
        guard repository != nil else { return 0 }
        guard let type = SectionTypes(rawValue: section) else {
            assert(false, "no type")
            return 0
        }
        switch type {
        case .header: return 1
        case .code: return 3
        case .info: return 5
        case .readMe: return repository?.mdText != nil ? 1 : 0
        }
    }

    func viewModel(_ indexPath: IndexPath) -> Any? {
        guard let repository = repository else { return nil }
        guard let type = SectionTypes(rawValue: indexPath.section) else { return nil }
        switch type {
        case .header:
            return RepositoryDetailsHeaderCellViewModel(repository: repository.repository)
        case .code:
            return codeViewModel(for: indexPath.row, repository: repository)
        case .info:
            return infoViewModel(for: indexPath.row, repository: repository)
        case .readMe:
            if let readMe = repository.mdText {
                return ReadMeCellViewModel(mdText: readMe)
            } else {
                return nil
            }
        }
    }

    func codeViewModel(for row: Int, repository: RepositoryDetails) -> Any? {
        switch row {
        case 0:
            let type = RepositoryRowType.currentBranch
            return RepositoryInfoCellViewModel(type: type, repository: repository)
        case 1:
            let type = RepositoryRowType.commits
            return RepositoryInfoCellViewModel(type: type, repository: repository)
        case 2:
            let type = RepositoryRowType.sources
            return RepositoryInfoCellViewModel(type: type, repository: repository)
        default:
            return nil
        }
    }

    func infoViewModel(for row: Int, repository: RepositoryDetails) -> Any? {
        switch row {
        case 0:
            let type = RepositoryRowType.issues
            return RepositoryInfoCellViewModel(type: type, repository: repository)
        case 1:
            let type = RepositoryRowType.pullRequests
            return RepositoryInfoCellViewModel(type: type, repository: repository)
        case 2:
            let type = RepositoryRowType.releases
            return RepositoryInfoCellViewModel(type: type, repository: repository)
        case 3:
            let type = RepositoryRowType.license
            return RepositoryInfoCellViewModel(type: type, repository: repository)
        case 4:
            let type = RepositoryRowType.subscribers
            return RepositoryInfoCellViewModel(type: type, repository: repository)
        default:
            return nil
        }
    }
}
