//
//  CommitResponse.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import Foundation

struct CommitResponseDTO: Codable {
    let sha: String
    let commit: CommitInfoResponseDTO
    let url: URL
    let htmlUrl: URL
    let commentsUrl: URL
    let author: UserResponseDTO
    let committer: UserResponseDTO
    let parents: [ParentCommitResponseDTO]

    func toDomain() -> Commit {
        .init(url: url,
              htmlUrl: htmlUrl,
              author: author.toDomain(),
              commiter: committer.toDomain(),
              parents: parents,
              message: commit.message,
              isVerified: commit.verification.verified,
              verificationReason: commit.verification.reason,
              createdAt: commit.committer.date.toDate(),
              commentCount: commit.commentCount)
    }
}
struct CommitInfoResponseDTO: Codable {
    let author: CommitAuthor
    let committer: CommitAuthor
    let message: String
    let commentCount: Int
    let verification: CommitVerification
}

struct ParentCommitResponseDTO: Codable {
    let sha: String
    let url: URL
    let htmlUrl: URL
}

struct CommitVerification: Codable {
    let verified: Bool
    let reason: String
    let signature: String?
    let payload: String?
}

struct CommitAuthor: Codable {
    let name: String
    let email: String
    let date: String
}
