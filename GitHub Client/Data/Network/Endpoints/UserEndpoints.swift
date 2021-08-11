//
//  UserEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

struct UserEndpoints {
    static func getProfile(login: String) -> Endpoint<UserResponseDTO> {
        return Endpoint(path: "users/\(login)")
    }

    static func getFollowers(login: String, page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "users/\(login)/followers",
                        queryParametersEncodable: ["page": page])
    }

    static func getFollowing(login: String, page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "users/\(login)/following",
                        queryParametersEncodable: ["page": page])
    }

    static func getRepositories(login: String, page: Int) -> Endpoint<[RepositoryResponseDTO]> {
        return Endpoint(path: "users/\(login)/repos",
                        queryParametersEncodable: ["page": page])
    }

    static func getStarredRepositories(login: String, page: Int) -> Endpoint<[RepositoryResponseDTO]> {
        return Endpoint(path: "users/\(login)/starred",
                        queryParametersEncodable: ["page": page])
    }
}
