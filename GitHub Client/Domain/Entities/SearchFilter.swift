//
//  SearchFilter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import Foundation

struct SearchFilter {
    enum FilterType: String, CaseIterable {
        case repositories
        case issues
        case pullRequests
        case people
    }

    enum RepositoriesSearchParameters: String, CaseIterable {
        case all
        case byName
        case byDescription
        case byReadMe

        func parameter(_ searchText: String) -> String {
            switch self {
            case .all:
                return "\(searchText) in:name,description"
            case .byName:
                return "\(searchText) in:name,description"
            case .byDescription:
                return "\(searchText) in:name,description"
            case .byReadMe:
                return "\(searchText) in:name,description"
            }
        }
    }

    enum IssuesSearchParameters: String, CaseIterable {
        case all
        case byTitle
        case byBody
        case byComments

        func parameter(_ searchText: String) -> String {
            switch self {
            case .all:
                return "\(searchText) in:title,body"
            case .byTitle:
                return "\(searchText) in:title,body"
            case .byBody:
                return "\(searchText) in:title,body"
            case .byComments:
                return "\(searchText) in:title,body"
            }
        }
    }

    enum PullReqestsSearchParameters: String, CaseIterable {
        case all
        case byTitle
        case byBody
        case byComments

        func parameter(_ searchText: String) -> String {
            switch self {
            case .all:
                return "\(searchText) in:title,body"
            case .byTitle:
                return "\(searchText) in:title,body"
            case .byBody:
                return "\(searchText) in:title,body"
            case .byComments:
                return "\(searchText) in:title,body"
            }
        }
    }

    enum UsersSearchParameters: String, CaseIterable {
        case all
        case byName
        case byLogin
        case byEmail

        func parameter(_ searchText: String) -> String {
            switch self {
            case .all:
                return "\(searchText) in:name"
            case .byName:
                return "\(searchText) in:name"
            case .byLogin:
                return "\(searchText) in:name"
            case .byEmail:
                return "\(searchText) in:name"
            }
        }
    }

    var repositoriesSearchParameters: RepositoriesSearchParameters
    var issuesSearchParameters: IssuesSearchParameters
    var pullReqestsSearchParameters: PullReqestsSearchParameters
    var usersSearchParameters: UsersSearchParameters
}
