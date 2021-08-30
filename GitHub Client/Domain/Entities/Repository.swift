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

    let htmlUrl: URL
    let forksUrl: URL
    let eventsUrl: URL
    let branchesUrl: URL
    let languagesUrl: URL
    let stargazersUrl: URL
    let subscribersUrl: URL
    let commitsUrl: URL
    let contentUrl: URL
    let issuesUrl: URL
    let pullsUrl: URL
}
