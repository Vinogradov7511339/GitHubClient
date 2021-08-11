//
//  CommitResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import Foundation

class CommitInfoResponse: Codable {
    let sha: String
    let nodeId: String
    let commit: CommitResponse
    let url: URL
    let htmlUrl: URL
    let commentsUrl: URL
    let author: UserResponseDTO
    let committer: UserResponseDTO
    let parents: [ParentCommit]

    init(
        sha: String,
        nodeId: String,
        commit: CommitResponse,
        url: URL,
        htmlUrl: URL,
        commentsUrl: URL,
        author: UserResponseDTO,
        committer: UserResponseDTO,
        parents: [ParentCommit]) {
        self.sha = sha
        self.nodeId = nodeId
        self.commit = commit
        self.url = url
        self.htmlUrl = htmlUrl
        self.commentsUrl = commentsUrl
        self.author = author
        self.committer = committer
        self.parents = parents
    }

    func toDomain() -> Commit {
        .init(sha: sha,
              message: commit.message,
              author: author.toDomain(),
              commentsCount: commit.commentCount)
    }
}

class ParentCommit: Codable {
    let sha: String
    let url: URL
    let htmlUrl: URL

    init(sha: String, url: URL, htmlUrl: URL) {
        self.sha = sha
        self.url = url
        self.htmlUrl = htmlUrl
    }
}

class CommitResponse: Codable {
    let author: CommitAuthor
    let committer: CommitAuthor
    let message: String
//    let tree
    let commentCount: Int
    let verification: CommitVerification

    init(
        author: CommitAuthor,
        committer: CommitAuthor,
        message: String,
        commentCount: Int,
        verification: CommitVerification) {
        self.author = author
        self.committer = committer
        self.message = message
        self.commentCount = commentCount
        self.verification = verification
    }
}

class CommitVerification: Codable {
    let verified: Bool
    let reason: String
    let signature: String?
    let payload: String?
    
    init(verified: Bool, reason: String, signature: String, payload: String) {
        self.verified = verified
        self.reason = reason
        self.signature = signature
        self.payload = payload
    }
}

class CommitAuthor: Codable {
    let name: String
    let email: String
    let date: String

    init(name: String, email: String, date: String) {
        self.name = name
        self.email = email
        self.date = date
    }
}
