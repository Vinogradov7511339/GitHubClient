//
//  RepositoryAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import Foundation

class RepositoryAdapter {
    
    static func toDBModel(_ dbRepository: RepositoryDBModel, from repository: Repository) {
        fatalError()
    }
    
    static func fromDBModel(_ repository: RepositoryDBModel) -> Repository {
        let owner: UserProfile?
        if let dbOwner = repository.owner {
            owner = UserProfileAdapter.fromDBModel(dbOwner)
        } else {
            owner = nil
        }
        
        let license: License?
        if let dbLicenseModel = repository.license {
            license = LicenseAdapter.fromDBModel(dbLicenseModel)
        } else {
            license = nil
        }
        
        return Repository(
            id: Int(repository.id),
            node_id: repository.node_id,
            name: repository.name,
            full_name: repository.full_name,
            owner: owner,
            html_url: repository.html_url,
            description: repository.descriptionStr,
            fork: repository.fork,
            url: repository.url,
            archive_url: repository.archive_path,
            assignees_url: repository.assignees_path,
            blobs_url: repository.blobs_path,
            branches_url: repository.branches_path,
            collaborators_url: repository.collaborators_path,
            comments_url: repository.comments_path,
            commits_url: repository.commits_path,
            compare_url: repository.compare_path,
            contents_url: repository.contents_path,
            contributors_url: repository.contributors_url,
            deployments_url: repository.deployments_url,
            downloads_url: repository.downloads_url,
            events_url: repository.events_url,
            forks_url: repository.forks_url,
            git_commits_url: repository.git_commits_path,
            git_refs_url: repository.git_refs_path,
            git_tags_url: repository.git_tags_path,
            git_url: repository.git_url,
            issue_comment_url: repository.issue_comment_path,
            issue_events_url: repository.issue_events_path,
            issues_url: repository.issues_path,
            keys_url: repository.keys_path,
            labels_url: repository.labels_path,
            languages_url: repository.languages_url,
            merges_url: repository.merges_url,
            milestones_url: repository.milestones_path,
            notifications_url: repository.notifications_path,
            pulls_url: repository.pulls_path,
            releases_url: repository.releases_path,
            ssh_url: repository.ssh_url,
            stargazers_url: repository.stargazers_url,
            statuses_url: repository.statuses_path,
            subscribers_url: repository.subscribers_url,
            subscription_url: repository.subscription_url,
            tags_url: repository.tags_url,
            teams_url: repository.teams_url,
            trees_url: repository.trees_path,
            clone_url: repository.clone_url,
            mirror_url: repository.mirror_path,
            hooks_url: repository.hooks_url,
            svn_url: repository.svn_url,
            homepage: repository.homepage,
            language: repository.language,
            forks_count: Int(repository.forksCount),
            stargazers_count: Int(repository.stargazersCount),
            watchers_count: Int(repository.watchersCount),
            size: Int(repository.size),
            default_branch: repository.default_branch,
            open_issues_count: Int(repository.open_issues_count),
            is_template: repository.is_template,
            topics: nil,
            has_issues: repository.has_issues,
            has_projects: repository.has_projects,
            has_wiki: repository.has_wiki,
            has_pages: repository.has_pages,
            has_downloads: repository.has_downloads,
            archived: repository.archived,
            disabled: repository.disabled,
            visibility: repository.visibility,
            pushed_at: repository.pushed_at,
            created_at: repository.created_at,
            updated_at: repository.updated_at,
            permissions: nil,
            template_repository: nil,
            license: license
        )
    }
}
