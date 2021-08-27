//
//  User.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.08.2021.
//
import Foundation

struct User: Identifiable, Equatable {
    enum UserType: String {
        case user = "User"
        case bot = "Bot"
        case organization = "Organization"
        case unknown
    }

    let id: Int
    let login: String
    let avatarUrl: URL
    let url: URL
    let type: UserType
}
