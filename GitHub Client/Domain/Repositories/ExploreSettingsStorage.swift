//
//  ExploreSettingsStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import Foundation

enum ExploreSettingsStorageType {
    case mostStarred(SearchRequestModel)
}

protocol ExploreSettingsStorage {
    var searchType: ExploreSettingsStorageType { get set }
}

final class ExploreSettingsStorageImpl {

    var searchType: ExploreSettingsStorageType

    init() {
        searchType = .mostStarred(Self.defaultModel)
    }
}

// MARK: - ExploreSettingsStorage
extension ExploreSettingsStorageImpl: ExploreSettingsStorage {}

// MARK: - Default request model
private extension ExploreSettingsStorageImpl {
    static var defaultModel: SearchRequestModel {
        .init(searchType: .repositories, searchText: "stars:>10000", perPage: 10, page: 1)
    }
}
