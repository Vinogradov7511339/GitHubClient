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

    static func followed(_ login: String) -> Endpoint<Void> {
        return Endpoint(path: "user/following/\(login)")
    }
}
