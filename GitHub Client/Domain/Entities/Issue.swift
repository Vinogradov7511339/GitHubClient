//
//  Issue.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct Issue: Identifiable, Equatable {
    let id: Int
    let number: Int
    let commentsURL: URL
    let state: String // change
    let title: String
    let body: String
    let user: User
    let commentsCount: Int
    let openedAt: Date
}
