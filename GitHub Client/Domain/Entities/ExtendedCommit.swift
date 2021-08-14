//
//  Commit.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//
import Foundation

struct Commit {
    let sha: String
    let author: Author
    let message: String
    let url: URL

    struct Author {
        let email: String
        let name: String
    }
}

struct ExtendedCommit {
    let sha: String
    let message: String
    let author: User
    let commiter: User
    let commentsCount: Int
}
