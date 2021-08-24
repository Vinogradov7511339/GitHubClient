//
//  Enums.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.08.2021.
//

import UIKit

protocol AnyEntity {}

enum SearchState {
    case results(SearchResultType)
    case typing(text: String)
    case empty
}

enum SearchResultType {
    case empty
//    case all(repList: SearchResponseModel<Repository>,
//             issues: SearchResponseModel<Issue>,
//             pullRequets: SearchResponseModel<PullRequest>,
//             users: SearchResponseModel<User>,
//             organizations: SearchResponseModel<Organization>)

    case results([SearchType: SearchResponseModel<Any>])
}

enum SearchType: Int, CaseIterable {
    case repositories
    case issues
    case pullRequests
    case people
    case organizations

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
        case .organizations:
            return NSLocalizedString("Organizations", comment: "")
        }
    }
}
