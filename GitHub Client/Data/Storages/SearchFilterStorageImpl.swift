//
//  SearchFilterStorageImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

final class SearchFilterStorageImpl {}

// MARK: - SearchFilterStorage
extension SearchFilterStorageImpl: SearchFilterStorage {
    func filter(for type: SearchFilterType) -> SearchFilter {
        switch type {
        case .all:
            return Self.defaultFilter
        }
    }
}

// MARK: - Default filter
private extension SearchFilterStorageImpl {
    static var defaultFilter: SearchFilter {
        .init(repositoriesSearchParameters: .all,
              issuesSearchParameters: .all,
              pullReqestsSearchParameters: .all,
              usersSearchParameters: .all)
    }
}
