//
//  UserDetails.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.08.2021.
//

import Foundation

struct UserProfile {
    let user: User
    let name: String?
    let bio: String?
    let location: String?
    let company: String?
    let userBlogUrl: URL?
    let userEmail: String?
    let followingCount: Int
    let followersCount: Int
    let gistsCount: Int
    let repositoriesCount: Int
    var lastEvents: [Event]
    var isFollowed: Bool?

    let htmlUrl: URL
    let followersUrl: URL
    let followingUrl: URL
    let gistsUrl: URL
    let starredUrl: URL
    let subscriptionsUrl: URL
    let organizationsUrl: URL
    let repositoriesUrl: URL
    let eventsUrl: URL
    let receivedEventsUrl: URL
}
