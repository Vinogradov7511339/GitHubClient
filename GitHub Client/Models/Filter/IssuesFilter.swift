//
//  IssuesFilter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import Foundation

//struct IssuesFilter {
//    enum FilterType: CaseIterable {
//        case issueState
//        case issueType
//        case issueVisability
//        case organization
//        case repository
//        case sortedBy
//    }
//
//    let type: FilterType
//    let filter: Filter
//}
//
//
//extension IssuesFilter {
//    static func all() -> [IssuesFilter] {
//        return FilterType.allCases.map { Self.filter(for: $0) }
//    }
//
//    static func filter(for type: IssuesFilter.FilterType) -> IssuesFilter {
//        let items = items(for: type)
//        return IssuesFilter(type: type, filter: Filter(selectedItem: nil, items: items))
//    }
//
//    private static func items(for type: IssuesFilter.FilterType) -> [String] {
//        switch type {
//        case .issueState:
//            return IssueState.allCases.map { $0.rawValue }
//        case .issueType:
//            return IssueType.allCases.map { $0.rawValue }
//        case .issueVisability:
//            return RepositoryVisibility.allCases.map { $0.rawValue }
//        case .sortedBy:
//            return SortType.allCases.map { $0.rawValue }
//        default:
//            return []
//        }
//    }
//
//    func a() -> RequestParameters {
//        switch type {
//        case .issueState:
//            return p(state: type)
//        default:
//            <#code#>
//        }
//    }
//
//    func p(state: IssueState) -> RequestParameters {
//        switch state {
//        case .open:
//            return IssueState.open.requestParameter
//        case .closed:
//            return IssueState.closed.requestParameter
//        case .all:
//            return IssueState.all.requestParameter
//        }
//
//    }
//}
//
//extension IssuesFilter {
//    enum IssueState: String, CaseIterable {
//        case open = "Open"
//        case closed = "Closed"
//        case all = "All"
//
//        var requestParameter: RequestParameters {
//            switch self {
//            case .open: return ["state": "open"]
//            case .closed: return ["state": "closed"]
//            case .all: return ["state": "all"]
//            }
//        }
//    }
//
//    enum IssueType: String, CaseIterable {
//        case created = "Created"
//        case assigned = "Assigned"
//        case mentioned = "Mentioned"
//        case all = "All"
//    }
//
//    enum RepositoryVisibility: String, CaseIterable {
//        case publicOnly = "Public repositories only"
//        case privateOnly = "Private repositories only"
//        case all = "All"
//    }
//
//    enum SortType: String, CaseIterable {
//        case newest = "Sort by: Newest"
//        case oldest = "Sort by: Oldest"
//    }
//}
