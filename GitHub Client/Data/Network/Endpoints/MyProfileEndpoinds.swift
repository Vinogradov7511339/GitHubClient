//
//  MyProfileEndpoinds.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

struct MyProfileEndpoinds {

    static func profile() -> Endpoint<UserDetailsResponseDTO> {
        Endpoint(path: "user")
    }

    static func followers(page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "user/followers",
                        queryParametersEncodable: ["page": page])
    }

    static func following(page: Int) -> Endpoint<[UserResponseDTO]> {
        return Endpoint(path: "user/following",
                        queryParametersEncodable: ["page": page])
    }

    static func repositories(page: Int) -> Endpoint<[RepositoryResponseDTO]> {
        return Endpoint(path: "user/repos",
                        queryParametersEncodable: ["page": page])
    }

    static func starredRepositories(page: Int) -> Endpoint<[RepositoryResponseDTO]> {
        return Endpoint(path: "user/starred",
                        queryParametersEncodable: ["page": page])
    }

    static func subscriptions(page: Int) -> Endpoint<[RepositoryResponseDTO]> {
        return Endpoint(path: "user/subscriptions",
                        queryParametersEncodable: ["page": page])
    }

    static func receivedEvents(_ model: EventsRequestModel) -> Endpoint<[EventResponseDTO]> {
        var params: QueryType = [:]
        params["page"] = "\(model.page)"
        params["per_page"] = "\(model.perPage)"

        return Endpoint(path: model.path.absoluteString, isFullPath: true,
                        queryParametersEncodable: params)
    }

    static func events(_ model: EventsRequestModel) -> Endpoint<[EventResponseDTO]> {
        var params: QueryType = [:]
        params["page"] = "\(model.page)"
        params["per_page"] = "\(model.perPage)"

        return Endpoint(path: model.path.absoluteString, isFullPath: true,
                        queryParametersEncodable: params)
    }

    static func issues(page: Int) -> Endpoint<[IssueResponseDTO]> {
        var params: QueryType = [:]
        params["page"] = "\(page)"
        params["filter"] = "all"
        return Endpoint(path: "issues",
                        queryParametersEncodable: params)
    }
}
