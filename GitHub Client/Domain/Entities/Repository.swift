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
    let contentPath: URL
    let currentBranch: String
}
