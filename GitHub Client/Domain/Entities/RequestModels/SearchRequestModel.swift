//
//  SearchRequestModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

struct SearchRequestModel {
    enum SearchType: String {
        case repositories = "/repositories"
        case issues = "/issues"
        case pullRequests = "/pr"
        case users = "/users"
    }

    enum Order: String {
        case asc
        case desc
    }

    enum Sort: String {
        case created
    }

    let searchType: SearchType
    let searchText: String
    let order: Order = .desc
    let sort: Sort = .created
    let perPage: Int
    let page: Int
}
