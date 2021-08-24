//
//  SearchType.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.08.2021.
//

import Foundation

enum SearchState {
    case results(SearchResultType)
    case typing(text: String)
    case empty
}

enum SearchResultType {
    case empty
    case results([SearchType: SearchResponseModel])
}

enum SearchType: Int, CaseIterable {
    case repositories
    case issues
    case pullRequests
    case people

    var title: String {
        switch self {
        case .repositories:
            return NSLocalizedString("Repositories", comment: "")
        case .issues:
            return NSLocalizedString("Issues", comment: "")
        case .pullRequests:
            return NSLocalizedString("Pull Requests", comment: "")
        case .people:
            return NSLocalizedString("People", comment: "")
        }
    }
}
