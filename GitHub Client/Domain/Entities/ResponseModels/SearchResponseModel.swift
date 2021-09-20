//
//  SearchResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import Foundation

struct SearchResponseModel {
    enum ItemType {
        case repository([Repository])
        case issue([Issue])
        case pullRequest([PullRequest])
        case users([User])
    }

    let itemsType: ItemType
    let lastPage: Int
    let total: Int

    var items: [Any] {
        switch itemsType {
        case .repository(let repositories):
            return repositories
        case .issue(let issues):
            return issues
        case .pullRequest(let pullRequets):
            return pullRequets
        case .users(let users):
            return users
        }
    }
}

extension SearchResponseModel {
    init(type: ItemType, response: HTTPURLResponse?, total: Int) {
        self.itemsType = type
        self.lastPage = response?.lastPage ?? 1
        self.total = total
    }
}
