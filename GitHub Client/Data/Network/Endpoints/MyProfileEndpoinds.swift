//
//  MyProfileEndpoinds.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

struct MyProfileEndpoinds {
    static func getMyProfile() -> Endpoint<UserResponseDTO> {
        return Endpoint(path: "user")
    }

    static func getMyFollowers(page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "user/followers",
                        queryParametersEncodable: ["page": page])
    }

    static func getMyFollowing(page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "user/following",
                        queryParametersEncodable: ["page": page])
    }

    static func getMyRepositories(page: Int) -> Endpoint<[RepositoryResponseDTO]> {
        return Endpoint(path: "user/repos",
                        queryParametersEncodable: ["page": page])
    }

    static func getMyStarredRepositories(page: Int) -> Endpoint<[RepositoryResponseDTO]> {
        return Endpoint(path: "user/starred",
                        queryParametersEncodable: ["page": page])
    }

    static func getMyIssues(page: Int) -> Endpoint<[IssueResponseDTO]> {
        var params: QueryType = [:]
        params["page"] = "\(page)"
        params["filter"] = "all"
        return Endpoint(path: "issues",
                        queryParametersEncodable: params)
    }

    static func getMyPullRequests(page: Int) -> Endpoint<[PullRequestResponseDTO]> {
        var params: QueryType = [:]
        params["page"] = "\(page)"
        params["state"] = "all"
        return Endpoint(path: "pulls",
                        queryParametersEncodable: params)
    }

//    static func recentEvents(page: Int) -> Endpoint<[]>
}
