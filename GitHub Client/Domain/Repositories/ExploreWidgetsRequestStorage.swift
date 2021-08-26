//
//  ExploreSettingsStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

enum ExploreWidgetsRequestType {
    case mostStarred
}

protocol ExploreWidgetsRequestStorage {
    func model(for type: ExploreWidgetsRequestType) -> SearchRequestModel
}
