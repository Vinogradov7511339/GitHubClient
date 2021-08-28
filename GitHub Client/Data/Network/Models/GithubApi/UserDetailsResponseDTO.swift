//
//  UserResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import Foundation

// https://docs.github.com/en/rest/reference/users
struct UserDetailsResponseDTO: Codable {
    let login: String
    let id: Int
    let nodeId: String?
    let avatarUrl: URL
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
    let type: String
    let siteAdmin: Bool?
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: String?
    let updatedAt: String?
    let privateGists: Int?
    let totalPrivateRepos: Int?
    let ownedPrivateRepos: Int?
    let diskUsage: Int?
    let collaborators: Int?
    let twoFactorAuthentication: Bool?
    let plan: Plan?

    func user() -> User {
        .init(id: id,
              login: login,
              avatarUrl: avatarUrl,
              url: url,
              type: User.UserType(rawValue: type) ?? .unknown)
    }

    func toDomain() -> UserProfile {
        .init(user: user(),
              name: name,
              bio: bio,
              location: location,
              company: company,
              userBlogUrl: URL(string: blog ?? ""),
              userEmail: email,
              followingCount: following,
              followersCount: followers,
              gistsCount: publicGists,
              repositoriesCount: publicRepos)
    }

    func mapToAuthotization() -> AuthenticatedUser {
        return .init(userDetails: toDomain(),
                     totalRepCount: totalPrivateRepos ?? -1,
                     totalOwnedRepCount: ownedPrivateRepos ?? -1)
    }

    struct Plan: Codable {
        let name: String?
        let space: Int?
        let privateRepos: Int?
        let collaborators: Int?
    }
}
