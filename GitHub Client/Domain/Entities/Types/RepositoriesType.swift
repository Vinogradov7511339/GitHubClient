//
//  RepositoriesType.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

enum RepositoriesType {
    case myRepositories
    case myStarred

    case userRepositories(User)
    case userStarred(User)

    case forks(Repository)
}
