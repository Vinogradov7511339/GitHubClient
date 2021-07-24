//
//  UserProfile.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import Foundation

// https://docs.github.com/en/rest/reference/users
struct UserProfile: Codable {
    let login: String?
    let id: Int
    let node_id: String?
    let avatar_url: URL?
    let gravatar_id: String?
    let url: URL
    let html_url: URL?
    let followers_url: URL?
    let following_url: String?//URL
    let gists_url: String?//URL
    let starred_url: String?//URL
    let subscriptions_url: URL?
    let organizations_url: URL?
    let repos_url: URL?
    let events_url: String?//URL
    let received_events_url: URL?
    let type: String?
    let site_admin: Bool?
    
    let name: String?
    let company: String?
    let blog: URL?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitter_username: String?
    let public_repos: Int?
    let public_gists: Int?
    let followers: Int?
    let following: Int?
    let created_at: String?
    let updated_at: String?
    let private_gists: Int?
    let total_private_repos: Int?
    let owned_private_repos: Int?
    let disk_usage: Int?
    let collaborators: Int?
    let two_factor_authentication: Bool?
    let plan: Plan?
    
    struct Plan: Codable {
        let name: String?
        let space: Int?
        let private_repos: Int?
        let collaborators: Int?
    }
}
