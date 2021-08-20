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

struct License: Codable {
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
class RepositoryResponseDTO: Codable {
    let id: Int
    let nodeId: String?
    let name: String?
    let fullName: String?
    let owner: UserResponseDTO?
    let `private`: Bool // private
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
    let homepage: URL?
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
    let templateRepository: RepositoryResponseDTO?
    let license: License?

    init(id: Int,
         nodeId: String?,
         name: String?,
         fullName: String?,
         owner: UserResponseDTO?,
         isPrivate: Bool,
         htmlUrl: URL?,
         description: String?,
         fork: Bool?,
         url: URL?,
         archiveUrl: String?,
         assigneesUrl: String?,
         blobsUrl: String?,
         branchesUrl: String?,
         collaboratorsUrl: String?,
         commentsUrl: String?,
         commitsUrl: String?,
         compareUrl: String?,
         contentsUrl: String?,
         contributorsUrl: URL?,
         deploymentsUrl: URL?,
         downloadsUrl: URL?,
         eventsUrl: URL?,
         forksUrl: URL?,
         gitCommitsrl: String?,
         gitRefsUrl: String?,
         gitTagsUrl: String?,
         gitUrl: URL?,
         issueCommentUrl: String?,
         issueEventsUrl: String?,
         issuesUrl: String?,
         keysUrl: String?,
         labelsUrl: String?,
         languagesUrl: URL?,
         mergesUrl: URL?,
         milestonesUrl: String?,
         notificationsUrl: String?,
         pullsUrl: String?,
         releasesUrl: String?,
         sshUrl: URL?,
         stargazersUrl: URL?,
         statusesUrl: String?,
         subscribersUrl: URL?,
         subscriptionUrl: URL?,
         tagsUrl: URL?,
         teamsUrl: URL?,
         treesUrl: String?,
         cloneUrl: URL?,
         mirrorUrl: String?,
         hooksUrl: URL?,
         svnUrl: URL?,
         homepage: URL?,
         language: String?,
         forksCount: Int?,
         stargazersCount: Int?,
         watchersCount: Int?,
         size: Int?,
         defaultBranch: String?,
         openIssuesCount: Int?,
         isTemplate: Bool?,
         topics: [String]?,
         hasIssues: Bool?,
         hasProjects: Bool?,
         hasWiki: Bool?,
         hasPages: Bool?,
         hasDownloads: Bool?,
         archived: Bool?,
         disabled: Bool?,
         visibility: String?,
         pushedAt: String?,
         createdAt: String?,
         updatedAt: String?,
         permissions: Permissions?,
         templateRepository: RepositoryResponseDTO?,
         license: License?) {
        self.id = id
        self.nodeId = nodeId
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.private = isPrivate
        self.htmlUrl = htmlUrl
        self.description = description
        self.fork = fork
        self.url = url
        self.archiveUrl = archiveUrl
        self.assigneesUrl = assigneesUrl
        self.blobsUrl = blobsUrl
        self.branchesUrl = branchesUrl
        self.collaboratorsUrl = collaboratorsUrl
        self.commentsUrl = commentsUrl
        self.commitsUrl = commitsUrl
        self.compareUrl = compareUrl
        self.contentsUrl = contentsUrl
        self.contributorsUrl = contributorsUrl
        self.deploymentsUrl = deploymentsUrl
        self.downloadsUrl = downloadsUrl
        self.eventsUrl = eventsUrl
        self.forksUrl = forksUrl
        self.gitCommitsrl = gitCommitsrl
        self.gitRefsUrl = gitRefsUrl
        self.gitTagsUrl = gitTagsUrl
        self.gitUrl = gitUrl
        self.issueCommentUrl = issueCommentUrl
        self.issueEventsUrl = issueEventsUrl
        self.issuesUrl = issuesUrl
        self.keysUrl = keysUrl
        self.labelsUrl = labelsUrl
        self.languagesUrl = languagesUrl
        self.mergesUrl = mergesUrl
        self.milestonesUrl = milestonesUrl
        self.notificationsUrl = notificationsUrl
        self.pullsUrl = pullsUrl
        self.releasesUrl = releasesUrl
        self.sshUrl = sshUrl
        self.stargazersUrl = stargazersUrl
        self.statusesUrl = statusesUrl
        self.subscribersUrl = subscribersUrl
        self.subscriptionUrl = subscriptionUrl
        self.tagsUrl = tagsUrl
        self.teamsUrl = teamsUrl
        self.treesUrl = treesUrl
        self.cloneUrl = cloneUrl
        self.mirrorUrl = mirrorUrl
        self.hooksUrl = hooksUrl
        self.svnUrl = svnUrl
        self.homepage = homepage
        self.language = language
        self.forksCount = forksCount
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.size = size
        self.defaultBranch = defaultBranch
        self.openIssuesCount = openIssuesCount
        self.isTemplate = isTemplate
        self.topics = topics
        self.hasIssues = hasIssues
        self.hasProjects = hasProjects
        self.hasWiki = hasWiki
        self.hasPages = hasPages
        self.hasDownloads = hasDownloads
        self.archived = archived
        self.disabled = disabled
        self.visibility = visibility
        self.pushedAt = pushedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.permissions = permissions
        self.templateRepository = templateRepository
        self.license = license
    }

    func toDomain() -> Repository? {
        let newPath = contentsUrl?.replacingOccurrences(of: "/{+path}", with: "") ?? ""
        guard let path = URL(string: newPath) else {
            return nil
        }
        return Repository(
            repositoryId: id,
            owner: owner!.toDomain(),
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
            currentBranch: defaultBranch ?? "NaN"
        )
    }
}
