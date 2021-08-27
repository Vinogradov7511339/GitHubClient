//
//  PullRequestDetails.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import Foundation

struct PullRequestDetails {
    let number: Int
    let htmlUrl: URL
    let state: PullRequestState
    let title: String
    let body: String
    let head: PRBaseResponseDTO
    let base: PRBaseResponseDTO
    let labels: [LabelResponseDTO]
    let commitsCount: Int
    let additionsCount: Int
    let deletionsCount: Int
    let changedFilesCount: Int
}
