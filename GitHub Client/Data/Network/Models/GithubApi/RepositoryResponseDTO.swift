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
    let name: String
    let fullName: String?
    let owner: UserResponseDTO
    let `private`: Bool? // private
    let htmlUrl: URL
    let description: String?
    let fork: Bool?
    let url: URL
    let archiveUrl: String?
    let assigneesUrl: String?
    let blobsUrl: String?
    let branchesUrl: String
    let collaboratorsUrl: String?
    let commentsUrl: String?
    let commitsUrl: String
    let compareUrl: String?
    let contentsUrl: String?
    let contributorsUrl: URL
    let deploymentsUrl: URL?
    let downloadsUrl: URL?
    let eventsUrl: URL
    let forksUrl: URL
    let gitCommitsrl: String?
    let gitRefsUrl: String?
    let gitTagsUrl: String?
    let gitUrl: URL?
    let issueCommentUrl: String?
    let issueEventsUrl: String?
    let issuesUrl: String
    let keysUrl: String?
    let labelsUrl: String?
    let languagesUrl: URL
    let mergesUrl: URL?
    let milestonesUrl: String?
    let notificationsUrl: String?
    let pullsUrl: String
    let releasesUrl: String
    let sshUrl: URL?
    let stargazersUrl: URL
    let statusesUrl: String?
    let subscribersUrl: URL
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
    let forksCount: Int
    let stargazersCount: Int
    let watchersCount: Int
    let size: Int?
    let defaultBranch: String
    let openIssuesCount: Int
    let isTemplate: Bool?
    let topics: [String]?
    let hasIssues: Bool
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
        let contentPath = contentsUrl?.replacingOccurrences(of: "/{+path}", with: "") ?? ""
        guard let contentUrl = URL(string: contentPath) else { return nil }

        let commitsPath = commitsUrl.replacingOccurrences(of: "{/sha}", with: "")
        guard let commitsUrl = URL(string: commitsPath) else { return nil }

        let branchesPath = branchesUrl.replacingOccurrences(of: "{/branch}", with: "")
        guard let branchesUrl = URL(string: branchesPath) else { return nil }

        let issuesPath = issuesUrl.replacingOccurrences(of: "{/number}", with: "")
        guard let issuesUrl = URL(string: issuesPath) else { return nil }

        let pullsPath = pullsUrl.replacingOccurrences(of: "{/number}", with: "")
        guard let pullsUrl = URL(string: pullsPath) else { return nil }

        let releasesPath = releasesUrl.replacingOccurrences(of: "{/id}", with: "")
        guard let releasesUrl = URL(string: releasesPath) else { return nil }

        return .init(repositoryId: id,
                     owner: owner.toDomain(),
                     name: name,
                     starsCount: stargazersCount,
                     forksCount: forksCount,
                     openIssuesCount: openIssuesCount,
                     watchersCount: watchersCount,
                     description: description,
                     language: language,
                     hasIssues: hasIssues,
                     homePage: homepage,
                     currentBranch: defaultBranch,
                     license: license?.name,
                     createdAt: createdAt?.toDate(),
                     lastUpdateAt: updatedAt?.toDate(),
                     url: url,
                     htmlUrl: htmlUrl,
                     forksUrl: forksUrl,
                     eventsUrl: eventsUrl,
                     branchesUrl: branchesUrl,
                     languagesUrl: languagesUrl,
                     stargazersUrl: stargazersUrl,
                     subscribersUrl: subscribersUrl,
                     contributorsUrl: contributorsUrl,
                     commitsUrl: commitsUrl,
                     contentUrl: contentUrl,
                     issuesUrl: issuesUrl,
                     pullsUrl: pullsUrl,
                     releasesUrl: releasesUrl)
    }
}
