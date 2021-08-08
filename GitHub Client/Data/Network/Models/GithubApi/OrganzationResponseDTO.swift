//
//  OrganzationResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct OrganzationResponseDTO: Codable {
    let login: String
    let id: Int
    let nodeId: String?
    let url: URL
    let reposUrl: URL?
    let eventsUrl: URL?
    let hooksUrl: URL?
    let issuesUrl: URL?
    let membersUrl: String?
    let publicMembersUrl: String?
    let avatarUrl: URL
    let description: String?
}
