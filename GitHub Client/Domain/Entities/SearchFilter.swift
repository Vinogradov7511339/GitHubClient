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
    }

    enum IssuesSearchParameters: String, CaseIterable {
        case all
        case byTitle
        case byBody
        case byComments
    }

    enum PullReqestsSearchParameters: String, CaseIterable {
        case all
        case byTitle
        case byBody
        case byComments
    }

    enum UsersSearchParameters: String, CaseIterable {
        case all
        case byName
        case byLogin
        case byEmail
    }

    var repositoriesSearchParameters: RepositoriesSearchParameters
    var issuesSearchParameters: IssuesSearchParameters
    var pullReqestsSearchParameters: PullReqestsSearchParameters
    var usersSearchParameters: UsersSearchParameters
}
