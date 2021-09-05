//
//  Release.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

import Foundation

struct Release {
    let id: Int
    let tagName: String
    let targetCommitish: String
    let name: String
    let body: String
    let createdAt: Date?
    let publishedAt: Date?
    let author: User
    let reactions: Reactions?

    let url: URL
    let htmlUrl: URL
}
