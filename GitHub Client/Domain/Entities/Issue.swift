//
//  Issue.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

struct Issue: Identifiable, Equatable {
    let id: Int
    let number: Int
    let state: String // change
    let title: String
    let body: String
    let user: User
}
