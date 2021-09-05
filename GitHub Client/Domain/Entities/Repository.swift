//
//  Repository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.08.2021.
//

import Foundation

struct Repository {
    let repositoryId: Int
    let owner: User
    let name: String
    let starsCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let watchersCount: Int
    let description: String?
    let language: String?
    let hasIssues: Bool
    let homePage: String?
    let currentBranch: String
    let license: String?
    let createdAt: Date?
    let lastUpdateAt: Date?
    let url: URL
    let htmlUrl: URL
    let forksUrl: URL
    let eventsUrl: URL
    let branchesUrl: URL
    let languagesUrl: URL
    let stargazersUrl: URL
    let subscribersUrl: URL
    let contributorsUrl: URL
    let commitsUrl: URL
    let contentUrl: URL
    let issuesUrl: URL
    let pullsUrl: URL
    let releasesUrl: URL
}
