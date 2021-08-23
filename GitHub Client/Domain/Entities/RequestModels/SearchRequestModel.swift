//
//  SearchRequestModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

struct SearchRequestModel {
    enum SearchType: String {
        case repositories
        case issues
        case users
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
}
