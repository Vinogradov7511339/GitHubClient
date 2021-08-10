//
//  User.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.08.2021.
//
import Foundation

struct User: Identifiable, Equatable {
    let id: Int
    let avatarUrl: URL
    let login: String
    let name: String?
    let bio: String?
}
