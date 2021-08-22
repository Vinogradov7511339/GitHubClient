//
//  ExploreTempEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

struct ExploreTempEndpoints {
    static func repositories() -> Endpoint<[RepositoryResponseDTO]> {
        Endpoint(path: "search/repositories")
    }
}
