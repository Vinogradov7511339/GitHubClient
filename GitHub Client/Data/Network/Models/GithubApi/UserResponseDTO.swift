//
//  UserResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import Foundation

// https://docs.github.com/en/rest/reference/users
struct UserResponseDTO: Codable {
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

    func toDomain() -> User {
        return User(
            id: id,
            avatarUrl: avatarUrl!,
            login: login,
            name: name,
            bio: bio
        )
    }

    func mapToDetails() -> UserDetails {
        return UserDetails(
            user: self.toDomain(),
            status: "ToDo",
            location: location,
            company: company,
            userBlogUrl: blog,
            userEmail: email,
            followingCount: following ?? 0,
            followersCount: followers ?? 0,
            gistsCount: publicGists ?? 0,
            repositoriesCount: publicRepos ?? 0
        )
    }

    func mapToAuthotization() -> AuthenticatedUser {
        let defaultUser = toDomain()
        let detailsUser = UserDetails(
            user: defaultUser,
            status: "NaN",
            location: location,
            company: company,
            userBlogUrl: blog,
            userEmail: email,
            followingCount: following ?? 0,
            followersCount: followers ?? 0,
            gistsCount: (publicGists ?? 0) + (privateGists ?? 0),
            repositoriesCount: (publicRepos ?? 0) + (totalPrivateRepos ?? 0)
        )
        return .init(userDetails: detailsUser,
                     totalRepCount: totalPrivateRepos ?? -1,
                     totalOwnedRepCount: ownedPrivateRepos ?? -1)
    }
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
