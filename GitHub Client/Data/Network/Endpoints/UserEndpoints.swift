//
//  UserEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

struct UserEndpoints {
    static func getProfile(login: String) -> Endpoint<UserResponseDTO> {
        return Endpoint(path: "users/\(login)",
                        headerParamaters: EndpointOld.defaultHeaders)
    }

    static func getFollowers(login: String, page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "users/\(login)/followers",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }

    static func getFollowing(login: String, page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "users/\(login)/following",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }

    static func getRepositories(login: String, page: Int) -> Endpoint<[RepositoryResponse]> {
        return Endpoint(path: "users/\(login)/repos",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }

    static func getStarredRepositories(login: String, page: Int) -> Endpoint<[RepositoryResponse]> {
        return Endpoint(path: "users/\(login)/starred",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }
}
