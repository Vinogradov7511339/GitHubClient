//
//  CommitResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import Foundation

struct CommitInfoResponse: Codable {
    let sha: String
    let nodeId: String
    let commit: CommitResponse
    let url: URL
    let htmlUrl: URL
    let commentsUrl: URL
    let author: UserResponseDTO
    let committer: UserResponseDTO
    let parents: [ParentCommit]

    func toDomain() -> ExtendedCommit {
        .init(sha: sha,
              message: commit.message,
              author: author.toDomain(),
              commiter: committer.toDomain(),
              commentsCount: commit.commentCount,
              createdAt: Date())
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
