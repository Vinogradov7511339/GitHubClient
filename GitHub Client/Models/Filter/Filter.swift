//
//  Filter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import Foundation

struct TempFilter {
    static let open = ["Open","Closed", "All"]
    static let created = ["Created", "Assigned", "Mentioned"]
    static let visability =  ["Show all", "Public repositories only", "Private repositories only"]
    static let organization = ["Organization"]
    static let repository = ["Repository"]
    static let sortBy = ["Newest", "Oldest"]

    static let issueFilters = [open, created, visability, organization, repository, sortBy]
}
class Filter {
    let name: String?
    let sortType: SortType
    
    init(sortType: SortType, name: String? = nil) {
        self.sortType = sortType
        self.name = name
    }
}

extension Filter {
    enum SortType {
        case newest
        case oldest
    }
}
