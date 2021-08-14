//
//  Commit.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

struct Commit {
    let sha: String
    let message: String
    let author: User
    let commiter: User
    let commentsCount: Int
}
