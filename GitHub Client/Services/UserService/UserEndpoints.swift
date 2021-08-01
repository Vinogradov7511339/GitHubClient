//
//  UserEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import Foundation
import Networking

enum UserEndpoints {
    case starred(user: UserProfile)
    case starredReposCount(user: UserProfile)
    case followers(user: UserProfile)
    case following(user: UserProfile)
    case subscriptions(user: UserProfile)
    case organizations(user: UserProfile)
    case repositories(user: UserProfile)
    case popularRepos(user: UserProfile)
    case myProfile
    case profile(user: UserProfile)
}

extension UserEndpoints: EndpointProtocol {
    var path: URL {
        switch self {
        case .starred(let user):
            guard let path = user.starredUrl?.pathWithoutParameters() else {
                fatalError()
            }
            return URL(string: path)!
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
        }
        
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var headers: RequestHeaders {
        return Endpoint.defaultHeaders
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
