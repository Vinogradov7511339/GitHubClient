//
//  BranchResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.08.2021.
//

import Foundation

struct BranchResponseDTO: Codable {
    let name: String
    let commit: Commit
    let protected: Bool

    struct Commit: Codable {
        let sha: String
        let url: URL
    }

    func toDomain() -> Branch {
        .init(name: name, commitPath: commit.url, isProtected: protected)
    }
}
