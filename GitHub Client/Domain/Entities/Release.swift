//
//  Release.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

struct Release: Identifiable, Equatable {
    let id: Int
    let name: String
    let body: String
    let createdAt: String
    let author: User
}
