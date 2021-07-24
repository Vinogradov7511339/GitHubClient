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
    let spdx_id: String?
    let node_id: String?
    let html_url: URL?
}

struct RepositoriesResponse: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Repository]?
}

// https://docs.github.com/en/rest/reference/repos
class Repository: Codable {
    let id: Int
    let node_id: String?
    let name: String?
    let full_name: String?
    let owner: UserProfile?
//    let isPrivate: Bool // private
    let html_url: URL?
    let description: String?
    let fork: Bool?
    let url: URL?
    let archive_url: String?
    let assignees_url: String?
    let blobs_url: String?
    let branches_url: String?
    let collaborators_url: String?
    let comments_url: String?
    let commits_url: String?
    let compare_url: String?
    let contents_url: String?
    let contributors_url: URL?
    let deployments_url: URL?
    let downloads_url: URL?
    let events_url: URL?
    let forks_url: URL?
    let git_commits_url: String?
    let git_refs_url: String?
    let git_tags_url: String?
    let git_url: URL?
    let issue_comment_url: String?
    let issue_events_url: String?
    let issues_url: String?
    let keys_url: String?
    let labels_url: String?
    let languages_url: URL?
    let merges_url: URL?
    let milestones_url: String?
    let notifications_url: String?
    let pulls_url: String?
    let releases_url: String?
    let ssh_url: URL?
    let stargazers_url: URL?
    let statuses_url: String?
    let subscribers_url: URL?
    let subscription_url: URL?
    let tags_url: URL?
    let teams_url: URL?
    let trees_url: String?
    let clone_url: URL?
    let mirror_url: String?
    let hooks_url: URL?
    let svn_url: URL?
    let homepage: String?
    let language: String?
    let forks_count: Int?
    let stargazers_count: Int?
    let watchers_count: Int?
    let size: Int?
    let default_branch: String?
    let open_issues_count: Int?
    let is_template: Bool?
    let topics: [String]?
    let has_issues: Bool?
    let has_projects: Bool?
    let has_wiki: Bool?
    let has_pages: Bool?
    let has_downloads: Bool?
    let archived: Bool?
    let disabled: Bool?
    let visibility: String?
    let pushed_at: String?
    let created_at: String?
    let updated_at: String?
    let permissions: Permissions?
    let template_repository: Repository?
    let license: License?
    
    init(id: Int, node_id: String?, name: String?, full_name: String?, owner: UserProfile?, html_url: URL?, description: String?, fork: Bool?, url: URL?, archive_url: String?, assignees_url: String?, blobs_url: String?, branches_url: String?, collaborators_url: String?, comments_url: String?, commits_url: String?, compare_url: String?, contents_url: String?, contributors_url: URL?, deployments_url: URL?, downloads_url: URL?, events_url: URL?, forks_url: URL?, git_commits_url: String?, git_refs_url: String?, git_tags_url: String?, git_url: URL?, issue_comment_url: String?, issue_events_url: String?, issues_url: String?, keys_url: String?, labels_url: String?, languages_url: URL?, merges_url: URL?, milestones_url: String?, notifications_url: String?, pulls_url: String?, releases_url: String?, ssh_url: URL?, stargazers_url: URL?, statuses_url: String?, subscribers_url: URL?, subscription_url: URL?, tags_url: URL?, teams_url: URL?, trees_url: String?, clone_url: URL?, mirror_url: String?, hooks_url: URL?, svn_url: URL?, homepage: String?, language: String?, forks_count: Int?, stargazers_count: Int?, watchers_count: Int?, size: Int?, default_branch: String?, open_issues_count: Int?, is_template: Bool?, topics: [String]?, has_issues: Bool?, has_projects: Bool?, has_wiki: Bool?, has_pages: Bool?, has_downloads: Bool?, archived: Bool?, disabled: Bool?, visibility: String?, pushed_at: String?, created_at: String?, updated_at: String?, permissions: Permissions?, template_repository: Repository?, license: License?) {
        self.id = id
        self.node_id = node_id
        self.name = name
        self.full_name = full_name
        self.owner = owner
        self.html_url = html_url
        self.description = description
        self.fork = fork
        self.url = url
        self.archive_url = archive_url
        self.assignees_url = assignees_url
        self.blobs_url = blobs_url
        self.branches_url = branches_url
        self.collaborators_url = collaborators_url
        self.comments_url = comments_url
        self.commits_url = commits_url
        self.compare_url = compare_url
        self.contents_url = contents_url
        self.contributors_url = contributors_url
        self.deployments_url = deployments_url
        self.downloads_url = downloads_url
        self.events_url = events_url
        self.forks_url = forks_url
        self.git_commits_url = git_commits_url
        self.git_refs_url = git_refs_url
        self.git_tags_url = git_tags_url
        self.git_url = git_url
        self.issue_comment_url = issue_comment_url
        self.issue_events_url = issue_events_url
        self.issues_url = issues_url
        self.keys_url = keys_url
        self.labels_url = labels_url
        self.languages_url = languages_url
        self.merges_url = merges_url
        self.milestones_url = milestones_url
        self.notifications_url = notifications_url
        self.pulls_url = pulls_url
        self.releases_url = releases_url
        self.ssh_url = ssh_url
        self.stargazers_url = stargazers_url
        self.statuses_url = statuses_url
        self.subscribers_url = subscribers_url
        self.subscription_url = subscription_url
        self.tags_url = tags_url
        self.teams_url = teams_url
        self.trees_url = trees_url
        self.clone_url = clone_url
        self.mirror_url = mirror_url
        self.hooks_url = hooks_url
        self.svn_url = svn_url
        self.homepage = homepage
        self.language = language
        self.forks_count = forks_count
        self.stargazers_count = stargazers_count
        self.watchers_count = watchers_count
        self.size = size
        self.default_branch = default_branch
        self.open_issues_count = open_issues_count
        self.is_template = is_template
        self.topics = topics
        self.has_issues = has_issues
        self.has_projects = has_projects
        self.has_wiki = has_wiki
        self.has_pages = has_pages
        self.has_downloads = has_downloads
        self.archived = archived
        self.disabled = disabled
        self.visibility = visibility
        self.pushed_at = pushed_at
        self.created_at = created_at
        self.updated_at = updated_at
        self.permissions = permissions
        self.template_repository = template_repository
        self.license = license
    }
}

