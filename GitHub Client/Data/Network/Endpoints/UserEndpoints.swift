//
//  UserEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

struct UserEndpoints {

    static func profile(_ url: URL) -> Endpoint<UserDetailsResponseDTO> {
        return Endpoint(path: url.absoluteString, isFullPath: true)
    }

    // old

    static func receivedEvents(login: String, page: Int) -> Endpoint<[EventResponseDTO]> {
        return Endpoint(path: "users/\(login)/received_events")
    }

    static func events(login: String, page: Int) -> Endpoint<[EventResponseDTO]> {
        return Endpoint(path: "users/\(login)/events/public")
    }
}
