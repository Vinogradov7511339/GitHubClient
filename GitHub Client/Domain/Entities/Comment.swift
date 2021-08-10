//
//  Comment.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

struct Comment: Identifiable, Equatable {
    // swiftlint:disable identifier_name
    let id: Int
    let body: String
    let user: User
//    let createdAt
//    let updatedAt
}
