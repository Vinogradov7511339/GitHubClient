//
//  RepositoryEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

import Foundation

struct RepositoryEndpoits {
    static func getStargazers(page: Int, repository: Repository) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/stargazers",
                        queryParametersEncodable: ["page": page])
    }

    static func getForks(page: Int, repository: Repository) -> Endpoint<[RepositoryResponseDTO]> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/forks",
                        queryParametersEncodable: ["page": page])
    }

    static func getIssues(page: Int, repository: Repository) -> Endpoint<[IssueResponseDTO]> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/issues",
                        queryParametersEncodable: ["page": page])
    }

    static func getPullRequests(page: Int, repository: Repository) -> Endpoint<[PullRequestResponseDTO]> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/pulls",
                        queryParametersEncodable: ["page": page])
    }

    static func getReleases(page: Int, repository: Repository) -> Endpoint<[ReleaseResponseDTO]> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/releases",
                        queryParametersEncodable: ["page": page])
    }

    static func getCommits(page: Int, repository: Repository) -> Endpoint<[CommitInfoResponse]> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/commits",
                        queryParametersEncodable: ["page": page])
    }

    static func getContents(path: URL) -> Endpoint<[DirectoryResponseModelDTO]> {
        return Endpoint(path: path.absoluteString, isFullPath: true)
    }

    static func getFile(path: URL) -> Endpoint<FileResponseModelDTO> {
        return Endpoint(path: path.absoluteString, isFullPath: true)
    }

    static func getReadMe(repository: Repository) -> Endpoint<FileResponseModelDTO> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/contents/README.md")
    }

    static func getRepository(repository: Repository) -> Endpoint<RepositoryResponseDTO> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)")
    }

    static func getBranches(repository: Repository) -> Endpoint<[BranchResponseDTO]> {
        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/branches")
    }
}
