//
//  Commit.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//
import Foundation

struct Commit {
    let url: URL
    let htmlUrl: URL
    let author: User
    let commiter: User
    let parents: [ParentCommitResponseDTO]
    let message: String
    let isVerified: Bool
    let verificationReason: String
    let createdAt: Date?
    let commentCount: Int
}

