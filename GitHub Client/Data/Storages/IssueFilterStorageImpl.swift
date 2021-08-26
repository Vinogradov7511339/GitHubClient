//
//  IssueFilterStorageImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

final class IssueFilterStorageImpl {}

// MARK: - IssueFilterStorage
extension IssueFilterStorageImpl: IssueFilterStorage {
    func filter(for type: IssueFilterType) -> IssuesFilter {
        switch type {
        case .all:
            return Self.defaultFilter
        case .open:
            return Self.onlyOpenFilter
        case .close:
            return Self.onlyCloseFilter
        case .custom:
            return Self.defaultFilter
        }
    }
}

// MARK: - Default filters
private extension IssueFilterStorageImpl {
    static var defaultFilter: IssuesFilter {
        .init(state: .all,
              sort: .created,
              direction: .descending,
              perPage: 30,
              assignee: nil,
              creator: nil,
              mentioned: nil,
              labels: [],
              since: nil)
    }

    static var onlyOpenFilter: IssuesFilter {
        .init(state: .all,
              sort: .created,
              direction: .descending,
              perPage: 30,
              assignee: nil,
              creator: nil,
              mentioned: nil,
              labels: [],
              since: nil)
    }

    static var onlyCloseFilter: IssuesFilter {
        .init(state: .all,
              sort: .created,
              direction: .descending,
              perPage: 30,
              assignee: nil,
              creator: nil,
              mentioned: nil,
              labels: [],
              since: nil)
    }
}
