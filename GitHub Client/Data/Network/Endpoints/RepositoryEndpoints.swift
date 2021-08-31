//
//  RepositoryEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

import Foundation

struct RepEndpoits {

    // MARK: - Repositories
    
    static func repository(_ url: URL) -> Endpoint<RepositoryResponseDTO> {
        return Endpoint(path: url.absoluteString, isFullPath: true)
    }

    // MARK: - Commits

    static func commit(_ commitUrl: URL) -> Endpoint<CommitResponseDTO> {
        return Endpoint(path: commitUrl.absoluteString, isFullPath: true)
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
        let filter = model.filter

        var params: QueryType = [:]
        params["state"] = filter.state.rawValue
        params["sort"] = filter.sort.rawValue
        params["direction"] = filter.direction.rawValue
        params["per_page"] = "\(filter.perPage)"
        params["page"] = "\(model.page)"

        if let assignee = filter.assignee {
            params["assignee"] = assignee
        }
        if let creator = filter.creator {
            params["creator"] = creator
        }
        if let mentioned = filter.mentioned {
            params["mentioned"] = mentioned
        }
        let labels = filter.labels.joined(separator: ",")
        if !labels.isEmpty {
            params["labels"] = labels
        }

        if let date = filter.since {
            let formatter = ISO8601DateFormatter()
            let dateStr = formatter.string(from: date)
            params["since"] = dateStr
        }

        return Endpoint(path: model.path.absoluteString,
                        isFullPath: true,
                        queryParametersEncodable: params)
    }

    static func issue(_ issue: Issue) -> Endpoint<IssueResponseDTO> {
        return Endpoint(path: issue.url.absoluteString, isFullPath: true)
    }

    static func issueComments(_ model: CommentsRequestModel<Issue>) -> Endpoint<[CommentResponseDTO]> {
        var params: QueryType = [:]
        params["page"] = "\(model.page)"
        return Endpoint(path: model.item.commentsURL.absoluteString,
                        isFullPath: true,
                        queryParametersEncodable: params)
    }

    // MARK: - Pull Requests

    static func pullRequests(_ model: PRListRequestModel) -> Endpoint<[PRResponseDTO]> {
        let page = model.page
        return Endpoint(path: model.path.absoluteString,
                        isFullPath: true,
                        queryParametersEncodable: ["page": page])
    }

    static func pullRequest(_ pullRequest: PullRequest) -> Endpoint<PRDetailsResponseDTO> {
        return Endpoint(path: pullRequest.url.absoluteString, isFullPath: true)
    }

    // MARK: - Releases

    static func release(_ model: ReleaseRequestModel) -> Endpoint<ReleaseResponseDTO> {
        let login = model.repository.owner.login
        let name = model.repository.name
        let releaseId = model.release.id
        return Endpoint(path: "repos/\(login)/\(name)/releases/\(releaseId)")
    }

    // MARK: - License

    static func license(_ model: LicenseRequestModel) -> Endpoint<LicenseResponseDTO> {
        fatalError()
    }

    // MARK: - Diff

    static func diff(_ path: URL) -> Endpoint<String> {
        return Endpoint(path: path.absoluteString, isFullPath: true, responseDecoder: TextResponseDecoder())
    }
}
