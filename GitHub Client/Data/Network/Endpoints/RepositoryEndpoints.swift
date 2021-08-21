//
//  RepositoryEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

import Foundation

struct RepEndpoits {

    // MARK: - Repositories

    static func repositories(_ model: RepListRequestModel) -> Endpoint<[RepositoryResponseDTO]> {
        fatalError()
    }

    static func repository(_ rep: Repository) -> Endpoint<RepositoryResponseDTO> {
        let login = rep.owner.login
        let name = rep.name
        return Endpoint(path: "repos/\(login)/\(name)")
    }

    // MARK: - Branches

    static func branches(_ model: BranchesRequestModel) -> Endpoint<[BranchResponseDTO]> {
        let login = model.repository.owner.login
        let name = model.repository.name
        return Endpoint(path: "repos/\(login)/\(name)/branches")
    }

    // MARK: - Commits

    static func commits(_ model: CommitsRequestModel) -> Endpoint<[CommitInfoResponse]> {
        let login = model.repository.owner.login
        let name = model.repository.name
        let page = model.page
        return Endpoint(path: "repos/\(login)/\(name)/commits",
                        queryParametersEncodable: ["page": page])
    }

    static func commit(_ model: CommitRequestModel) -> Endpoint<CommitInfoResponse> {
        fatalError()
    }

    // MARK: - Content

    static func folder(_ path: URL) -> Endpoint<[DirectoryResponseModelDTO]> {
        return Endpoint(path: path.absoluteString, isFullPath: true)
    }

    static func file(_ path: URL) -> Endpoint<FileResponseModelDTO> {
        return Endpoint(path: path.absoluteString, isFullPath: true)
    }

    static func readMe(_ repository: Repository) -> Endpoint<FileResponseModelDTO> {
        let login = repository.owner.login
        let name = repository.name
        return Endpoint(path: "repos/\(login)/\(name)/contents/README.md")
    }

    // MARK: - Issues

    static func issues(_ model: IssuesRequestModel) -> Endpoint<[IssueResponseDTO]> {
        fatalError()
//        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/issues",
//                        queryParametersEncodable: ["page": page])
    }

    static func issue(_ moodel: IssueRequestModel) -> Endpoint<IssueResponseDTO> {
        fatalError()
    }

    static func issueComments(_ model: CommentsRequestModel<Issue>) -> Endpoint<[CommentResponseDTO]> {
        fatalError()
    }

    // MARK: - Pull Requests

    static func pullRequests(_ model: PRListRequestModel) -> Endpoint<[PullRequestResponseDTO]> {
        let login = model.repository.owner.login
        let name = model.repository.name
        let page = model.page
        return Endpoint(path: "repos/\(login)/\(name)/pulls",
                        queryParametersEncodable: ["page": page])
    }

    static func pullRequest(_ model: PRRequestModel) -> Endpoint<PullRequestResponseDTO> {
        fatalError()
    }

    // MARK: - Releases

    static func releases(_ model: ReleasesRequestModel) -> Endpoint<[ReleaseResponseDTO]> {
        fatalError()
    }

    static func release(_ model: ReleaseRequestModel) -> Endpoint<ReleaseResponseDTO> {
        fatalError()
    }

    // MARK: - License

    static func license(_ model: LicenseRequestModel) -> Endpoint<LicenseResponseDTO> {
        fatalError()
    }

    // MARK: - Watchers

    static func watchers(_ model: WatchersRequestModel) -> Endpoint<[UserResponseDTO]> {
        fatalError()
//        return Endpoint(path: "repos/\(repository.owner.login)/\(repository.name)/stargazers",
//                        queryParametersEncodable: ["page": page])
    }

    // MARK: - Forks

    static func forks(_ model: ForksRequestModel) -> Endpoint<[RepositoryResponseDTO]> {
        let login = model.repository.owner.login
        let name = model.repository.name
        let page = model.page
        return Endpoint(path: "repos/\(login)/\(name)/forks",
                        queryParametersEncodable: ["page": page])
    }
}
