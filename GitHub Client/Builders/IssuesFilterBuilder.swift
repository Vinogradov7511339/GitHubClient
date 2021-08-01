//
//  IssuesFilterBuilder.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import Foundation

//class IssuesFilterBuilder {
//    private(set) var sortedBy: Filter.SortType = .newest
//    private(set) var state: IssuesFilter.IssueState = .all
//    private(set) var type: IssuesFilter.IssueType = .all
//    private(set) var visibility: IssuesFilter.RepositoryVisibility = .all
//    private(set) var organization: String? = nil
//    private(set) var repository: String? = nil
//    
//    func setSortType(_ sortedBy: Filter.SortType) -> IssuesFilterBuilder {
//        self.sortedBy = sortedBy
//        return self
//    }
//    
//    func setState(_ state: IssuesFilter.IssueState) -> IssuesFilterBuilder {
//        self.state = state
//        return self
//    }
//    
//    func setType(_ type: IssuesFilter.IssueType) -> IssuesFilterBuilder {
//        self.type = type
//        return self
//    }
//    
//    func setVisibility(_ visibility: IssuesFilter.RepositoryVisibility) -> IssuesFilterBuilder {
//        self.visibility = visibility
//        return self
//    }
//    
//    func setOrganization(_ organization: String) -> IssuesFilterBuilder {
//        self.organization = organization
//        return self
//    }
//    
//    func setRepository(_ repository: String) -> IssuesFilterBuilder {
//        self.repository = repository
//        return self
//    }
//    
//    func buld() -> IssuesFilter {
//        return IssuesFilter(
//            sortBy: sortedBy,
//            state: state,
//            type: type,
//            visability: visibility,
//            organization: organization,
//            repository: repository)
//    }
//}
