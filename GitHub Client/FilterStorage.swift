//
//  FilterStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.08.2021.
//

import Foundation

class FilterStorage {
    static let shared = FilterStorage()

    func getIssuesFilter() -> IssuesFilters {
        return IssuesFilters(
            filter: "all",
            state: "all",
            sort: "created",
            direction: "desc"
        )
    }

    func setIssueFilter(_ filter: IssuesFilters) {}
}
