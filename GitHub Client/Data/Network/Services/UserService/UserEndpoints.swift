//
//  UserEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import Foundation
import Networking

enum UserEndpoints {
    case starred(user: UserResponseDTO)
    case starred2(login: String)
    case starredReposCount(user: UserResponseDTO)
    case followers(user: UserResponseDTO)
    case following(user: UserResponseDTO)
    case subscriptions(user: UserResponseDTO)
    case organizations(user: UserResponseDTO)
    case repositories(user: UserResponseDTO)
    case popularRepos(user: UserResponseDTO)
    case myProfile
    case myProfileWithToken(token: TokenResponse)
    case profile(user: UserResponseDTO)
}

extension UserEndpoints: EndpointProtocol {
    var path: URL {
        switch self {
        case .starred(let user):
            guard let path = user.starredUrl?.pathWithoutParameters() else {
                fatalError()
            }
            return URL(string: path)!
        case .starred2(let login):
            return URL(string: "https://api.github.com/users/\(login)/starred")!
        case .starredReposCount(let user):
            guard let path = user.starredUrl?.pathWithoutParameters() else {
                fatalError()
            }
            return URL(string: path)!
        case .following(let user):
            guard let path = user.followingUrl?.pathWithoutParameters() else {
                fatalError()
            }
            return URL(string: path)!
        case .followers(let user):
            return user.followersUrl!
        case .subscriptions(let user):
            return user.followersUrl!
        case .organizations(let user):
            return user.organizationsUrl!
        case .repositories(let user), .popularRepos(let user):
            return user.reposUrl!
        case .myProfile:
            return  URL(string: "https://api.github.com/user")!
        case .profile(let user):
            return URL(string: "https://api.github.com/users/\(user.login)")!
        case .myProfileWithToken(_):
            return  URL(string: "https://api.github.com/user")!
        }
    }
    
    var method: RequestMethod {
        return .get
    }

    var headers: RequestHeaders {
        switch self {
        case .myProfileWithToken(let token):
            var headers: [String: String] = [:]
            headers["Authorization"] = token.accessToken
            headers["Accept"] = "application/vnd.github.v3+json"
            return headers
        default:
            return Endpoint.defaultHeaders
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .starredReposCount(_):
            var params: [String: String] = [:]
            params["per_page"] = "1"
            return params
        case .popularRepos(_):
            var params: [String: String] = [:]
            params["per_page"] = "10"
            return params
        default:
            return [:]
        }
    }

    var jsonBody: Data? {
        return nil
    }
}
