//
//  MyProfileEndpoinds.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

struct MyProfileEndpoinds {
    static func getMyProfile() -> Endpoint<UserResponseDTO> {
        return Endpoint(path: "user",
                        headerParamaters: EndpointOld.defaultHeaders)
    }

    static func getMyFollowers(page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "user/followers",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }

    static func getMyFollowing(page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "user/following",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }

    static func getMyRepositories(page: Int) -> Endpoint<[RepositoryResponse]> {
        return Endpoint(path: "user/repos",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }

    static func getMyStarredRepositories(page: Int) -> Endpoint<[RepositoryResponse]> {
        return Endpoint(path: "user/starred",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }

//    static func recentEvents(page: Int) -> Endpoint<[]>

    static var defaultHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Authorization"] = authorizationHeader
        headers["Accept"] = "application/vnd.github.v3+json"
        return headers
    }

    static var authorizationHeader: String {
        if let tokenResponse = UserStorage.shared.token {
            return "token \(tokenResponse.accessToken)"
        } else {
            return ""
        }
    }
}
