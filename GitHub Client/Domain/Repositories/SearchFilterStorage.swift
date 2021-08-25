//
//  SearchFilterStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import Foundation

protocol SearchFilterStorage {
    var filter: SearchFilter { get }
}

final class SearchFilterStorageImpl {

    static let shared = SearchFilterStorageImpl()

    var filter: SearchFilter

    private init() {
        filter = Self.defaultFilter
    }
}

// MARK: - SearchFilterStorage
extension SearchFilterStorageImpl: SearchFilterStorage {}

// MARK: - Default filter
private extension SearchFilterStorageImpl {

    static var defaultFilter: SearchFilter {
        SearchFilter(repositoriesSearchParameters: .all,
                     issuesSearchParameters: .all,
                     pullReqestsSearchParameters: .all,
                     usersSearchParameters: .all)
    }
}
