//
//  UserProfile.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import Foundation

// https://docs.github.com/en/rest/reference/users
struct UserProfile: Codable {
    let login: String
    let id: Int
    let nodeId: String?
    let avatarUrl: URL?
    let gravatarId: String?
    let url: URL
    let htmlUrl: URL?
    let followersUrl: URL?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionsUrl: URL?
    let organizationsUrl: URL?
    let reposUrl: URL?
    let eventsUrl: String?
    let receivedEventsUrl: URL?
    let type: String?
    let siteAdmin: Bool?
    let name: String?
    let company: String?
    let blog: URL?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let createdAt: String?
    let updatedAt: String?
    let privateGists: Int?
    let totalPrivateRepos: Int?
    let ownedPrivateRepos: Int?
    let diskUsage: Int?
    let collaborators: Int?
    let twoFactorAuthentication: Bool?
    let plan: Plan?

//    enum CodingKeys: String, CodingKey {
//        case login
//        case userId = "id"
//        case nodeId = "node_id"
//        case avatarUrl = "avatar_url"
//        case gravatarId = "gravatar_id"
//        case url = "url"
//        case htmlUrl = "html_url"
//        case followersUrl = "followers_url"
//        case followingUrl = "following_url"
//        case gistsUrl = "gists_url"
//        case starredUrl = "starred_url"
//        case subscriptionsUrl = "subscriptions_url"
//        case organizationsUrl = "organizations_url"
//        case reposUrl = "repos_url"
//        case eventsUrl = "events_url"
//        case receivedEventsUrl = "received_events_url"
//        case type = "type"
//        case isSiteAdmin = "site_admin"
//        case name = "name"
//        case company = "company"
//        case blog = "blog"
//        case location = "location"
//        case email = "email"
//        case hireable = "hireable"
//        case bio = "bio"
//        case twitterUsername = "twitter_username"
//        case publicRepos = "public_repos"
//        case publicGists = "public_gists"
//        case followers = "followers"
//        case following = "following"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case privateGists = "private_gists"
//        case totalPrivateRepos = "total_private_repos"
//        case ownedPrivateRepos = "owned_private_repos"
//        case diskUsage = "disk_usage"
//        case collaborators = "collaborators"
//        case twoFactorAuthentication = "two_factor_authentication"
//        case plan = "plan"
//    }

    struct Plan: Codable {
        let name: String?
        let space: Int?
        let privateRepos: Int?
        let collaborators: Int?

        enum CodingKeys: String, CodingKey {
            case name
            case space
            case privateRepos = "private_repos"
            case collaborators
        }
    }
}
