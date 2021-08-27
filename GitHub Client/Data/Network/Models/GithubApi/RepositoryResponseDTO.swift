//
//  Repository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.07.2021.
//

import Foundation

struct Permissions: Codable {
    let admin: Bool?
    let push: Bool?
    let pull: Bool?
}

struct LicenseResponseDTO: Codable {
    let key: String?
    let name: String?
    let url: URL?
    let spdxId: String?
    let nodeId: String?
    let htmlUrl: URL?
}

struct RepositoriesResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepositoryResponseDTO]?
}

// https://docs.github.com/en/rest/reference/repos
struct RepositoryResponseDTO: Codable {
    let id: Int
    let nodeId: String?
    let name: String?
    let fullName: String?
    let owner: UserResponseDTO
    let `private`: Bool? // private
    let htmlUrl: URL?
    let description: String?
    let fork: Bool?
    let url: URL?
    let archiveUrl: String?
    let assigneesUrl: String?
    let blobsUrl: String?
    let branchesUrl: String?
    let collaboratorsUrl: String?
    let commentsUrl: String?
    let commitsUrl: String?
    let compareUrl: String?
    let contentsUrl: String?
    let contributorsUrl: URL?
    let deploymentsUrl: URL?
    let downloadsUrl: URL?
    let eventsUrl: URL?
    let forksUrl: URL?
    let gitCommitsrl: String?
    let gitRefsUrl: String?
    let gitTagsUrl: String?
    let gitUrl: URL?
    let issueCommentUrl: String?
    let issueEventsUrl: String?
    let issuesUrl: String?
    let keysUrl: String?
    let labelsUrl: String?
    let languagesUrl: URL?
    let mergesUrl: URL?
    let milestonesUrl: String?
    let notificationsUrl: String?
    let pullsUrl: String?
    let releasesUrl: String?
    let sshUrl: URL?
    let stargazersUrl: URL?
    let statusesUrl: String?
    let subscribersUrl: URL?
    let subscriptionUrl: URL?
    let tagsUrl: URL?
    let teamsUrl: URL?
    let treesUrl: String?
    let cloneUrl: URL?
    let mirrorUrl: String?
    let hooksUrl: URL?
    let svnUrl: URL?
    let homepage: String?
    let language: String?
    let forksCount: Int?
    let stargazersCount: Int?
    let watchersCount: Int?
    let size: Int?
    let defaultBranch: String?
    let openIssuesCount: Int?
    let isTemplate: Bool?
    let topics: [String]?
    let hasIssues: Bool?
    let hasProjects: Bool?
    let hasWiki: Bool?
    let hasPages: Bool?
    let hasDownloads: Bool?
    let archived: Bool?
    let disabled: Bool?
    let visibility: String?
    let pushedAt: String?
    let createdAt: String?
    let updatedAt: String?
    let permissions: Permissions?
    let license: LicenseResponseDTO?

    func toDomain() -> Repository? {
        let newPath = contentsUrl?.replacingOccurrences(of: "/{+path}", with: "") ?? ""
        guard let path = URL(string: newPath) else {
            return nil
        }
        return Repository(
            repositoryId: id,
            owner: owner.toDomain(),
            name: name!,
            starsCount: stargazersCount ?? 0,
            forksCount: forksCount ?? 0,
            openIssuesCount: openIssuesCount ?? 0,
            watchersCount: watchersCount ?? 0,
            description: description,
            language: language,
            hasIssues: hasIssues ?? false,
            homePage: homepage,
            contentPath: path,
            currentBranch: defaultBranch ?? "NaN",
            license: license?.name
        )
    }
}
