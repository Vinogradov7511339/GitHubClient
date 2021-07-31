//
//  IssuesFilter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import Foundation

class IssuesFilter: Filter {
    
    let state: IssueState
    let type: IssueType
    let visability: RepositoryVisibility
    let organization: String?
    let repository: String?
    
    init(sortBy: Filter.SortType,
         state: IssueState,
         type: IssueType,
         visability: RepositoryVisibility,
         organization: String? = nil,
         repository: String? = nil,
         name: String? = nil) {
        self.state = state
        self.type = type
        self.visability = visability
        self.organization = organization
        self.repository = repository
        super.init(sortType: sortBy, name: name)
    }
}

extension IssuesFilter {
    enum IssueState: String {
        case open = "Open"
        case closed = "Closed"
        case all = "All"
    }
    
    enum IssueType: String {
        case created = "Created"
        case assigned = "Assigned"
        case mentioned = "Mentioned"
        case all = "All"
    }
    
    enum RepositoryVisibility: String {
        case publicOnly = "Public repositories only"
        case privateOnly = "Private repositories only"
        case all = "All"
    }
}
