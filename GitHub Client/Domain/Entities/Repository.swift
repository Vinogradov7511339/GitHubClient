//
//  Repository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.08.2021.
//

struct Repository {
    let repositoryId: Int
    let owner: User
    let name: String
    let starsCount: Int
    let description: String?
    let language: String?
}
