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

    static func getMyFollowers() -> Endpoint<UserResponseDTO> {
        return Endpoint(path: "followers",
                        headerParamaters: EndpointOld.defaultHeaders)
    }

    static func getMyFollowing() -> Endpoint<UserResponseDTO> {
        return Endpoint(path: "following",
                        headerParamaters: EndpointOld.defaultHeaders)
    }

    static func getMyRepositories() -> Endpoint<UserResponseDTO> {
        return Endpoint(path: "repos",
                        headerParamaters: EndpointOld.defaultHeaders)
    }

    static func getMyStarredRepositories() -> Endpoint<UserResponseDTO> {
        return Endpoint(path: "starred",
                        headerParamaters: EndpointOld.defaultHeaders)
    }
}
