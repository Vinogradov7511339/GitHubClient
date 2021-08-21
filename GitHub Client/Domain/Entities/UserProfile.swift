//
//  UserDetails.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.08.2021.
//

import Foundation

struct UserProfile {
    let user: User
    let status: String?
    let location: String?
    let company: String?
    let userBlogUrl: URL?
    let userEmail: String?
    let followingCount: Int
    let followersCount: Int
    let gistsCount: Int
    let repositoriesCount: Int
}
