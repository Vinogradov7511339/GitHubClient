//
//  IssueFilterStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

enum IssueFilterType {
    case all
    case open
    case close
    case custom
}

protocol IssueFilterStorage {
    func filter(for type: IssueFilterType) -> IssuesFilter
}
