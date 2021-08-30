//
//  UserEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

struct UserEndpoints {

    static func followers(_ model: UsersRequestModel) -> Endpoint<[UserResponseDTO]> {
        let login = model.user.login
        let page = model.page
        return Endpoint(path: "users/\(login)/followers",
                        queryParametersEncodable: ["page": page])
    }

    static func following(_ model: UsersRequestModel) -> Endpoint<[UserResponseDTO]> {
        let login = model.user.login
        let page = model.page
        return Endpoint(path: "users/\(login)/following",
                        queryParametersEncodable: ["page": page])
    }

    static func profile(_ url: URL) -> Endpoint<UserDetailsResponseDTO> {
        return Endpoint(path: url.absoluteString, isFullPath: true)
    }

    static func repositories(_ model: UsersRequestModel) -> Endpoint<[RepositoryResponseDTO]> {
        let login = model.user.login
        let page = model.page
        return Endpoint(path: "users/\(login)/repos",
                        queryParametersEncodable: ["page": page])
    }

    static func starred(_ model: UsersRequestModel) -> Endpoint<[RepositoryResponseDTO]> {
        let login = model.user.login
        let page = model.page
        return Endpoint(path: "users/\(login)/starred",
                        queryParametersEncodable: ["page": page])
    }

    // old

    static func receivedEvents(login: String, page: Int) -> Endpoint<[EventResponseDTO]> {
        return Endpoint(path: "users/\(login)/received_events")
    }

    static func events(login: String, page: Int) -> Endpoint<[EventResponseDTO]> {
        return Endpoint(path: "users/\(login)/events/public")
    }
}
