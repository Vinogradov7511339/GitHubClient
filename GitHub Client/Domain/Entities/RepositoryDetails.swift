//
//  RepositoryDetails.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.08.2021.
//

struct RepositoryDetails {
    let repository: Repository
    let forksCount: Int
    let isStarred: Bool
    let isWatched: Bool
    let issuesCount: Int
    let pullRequestsCount: Int
    let releasesCount: Int
    let watchersCount: Int
    let licenseName: String // license model
    let commitsCount: Int
}
