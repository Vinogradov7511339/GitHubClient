//
//  GitHubEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation
import Networking

enum GitHubEndpoints {
    case myFollowers(page: Int)
    case myFollowing(page: Int)
    case myRepositories(page: Int)
    case myStarredRepositories(page: Int)

    case userFollowers(page: Int, user: User)
    case userFollowings(page: Int, user: User)
    case userRepositories(page: Int, user: User)
    case userStarredRepositories(page: Int, user: User)
}

extension GitHubEndpoints: EndpointProtocol {
    var path: URL {
        switch self {
        case .myFollowers(_):
            return URL(string: "https://api.github.com/user/followers")!
        case .myFollowing(_):
            return URL(string: "https://api.github.com/user/following")!
        case .myRepositories(_):
            return URL(string: "https://api.github.com/user/repos")!
        case .myStarredRepositories(_):
            return URL(string: "https://api.github.com/user/starred")!
        case .userFollowers(_, let user):
            return URL(string: "https://api.github.com/users/\(user.login)/followers")!
        case .userFollowings(_, let user):
            return URL(string: "https://api.github.com/users/\(user.login)/following")!
        case .userRepositories(_, let user):
            return URL(string: "https://api.github.com/users/\(user.login)/repos")!
        case .userStarredRepositories(_, let user):
            return URL(string: "https://api.github.com/users/\(user.login)/starred")!
        }
    }

    var method: RequestMethod {
        return .get
    }

    var headers: RequestHeaders {
        return Self.defaultHeaders
    }

    var parameters: RequestParameters {
        switch self {
        case .myFollowers(let page),
             .myFollowing(let page),
             .myRepositories(let page),
             .myStarredRepositories(let page),
             .userFollowers(let page, _),
             .userFollowings(let page, _),
             .userRepositories(let page, _),
             .userStarredRepositories(let page, _):
            var parametes: RequestParameters = [:]
            parametes["page"] = "\(page)"
//            parametes["per_page"] = "\(1)"
            return parametes
        }
    }

    var jsonBody: Data? {
        return nil
    }
}

extension GitHubEndpoints {
    static var defaultHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Authorization"] = authorizationHeader
        headers["Accept"] = "application/vnd.github.v3+json"
        return headers
    }

    static var authorizationHeader: String {
        if let tokenResponse = UserStorage.shared.token {
            return "token \(tokenResponse.accessToken)"
        } else {
            return ""
        }
    }
}
