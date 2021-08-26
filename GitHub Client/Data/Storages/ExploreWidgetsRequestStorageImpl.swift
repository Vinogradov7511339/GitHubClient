//
//  ExploreWidgetsRequestStorageImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

final class ExploreWidgetsRequestStorageImpl {}

// MARK: - ExploreWidgetsRequestStorage
extension ExploreWidgetsRequestStorageImpl: ExploreWidgetsRequestStorage {
    func model(for type: ExploreWidgetsRequestType) -> SearchRequestModel {
        switch type {
        case .mostStarred:
            return Self.defaultModel
        }
    }
}

// MARK: - Default request model
private extension ExploreWidgetsRequestStorageImpl {
    static var defaultModel: SearchRequestModel {
        .init(searchType: .repositories, searchText: "stars:>10000", perPage: 10, page: 1)
    }
}
