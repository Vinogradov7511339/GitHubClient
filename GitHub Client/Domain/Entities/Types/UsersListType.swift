//
//  UsersListType.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

enum UsersListType {
//    case myFollowers
//    case myFollowing

    case userFollowers(User)
    case userFollowings(User)

//    case stargazers(Repository)
}
