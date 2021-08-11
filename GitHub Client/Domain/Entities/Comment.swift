//
//  Comment.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

struct Comment: Identifiable, Equatable {
    let id: Int
    let body: String
    let user: User
//    let createdAt
//    let updatedAt
}
