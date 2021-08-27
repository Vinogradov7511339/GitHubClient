//
//  PullRequest.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

struct PullRequest: Identifiable, Equatable {
    let id: Int
    let number: Int
    let state: String // todo
    let title: String
    let user: User
    let body: String?
    let assignedTo: User
}
