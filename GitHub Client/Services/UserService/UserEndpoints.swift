//
//  UserEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import Foundation

enum UserEndpoints {
    case starred(user: UserProfile)
    case followers(user: UserProfile)
    case following(user: UserProfile)
    case subscriptions(user: UserProfile)
    case organizations(user: UserProfile)
    case repositories(user: UserProfile)
    case myProfile
}

extension UserEndpoints: EndpointProtocol {
    var path: URL {
        switch self {
        case .starred(let user), .following(let user):
            guard let path = user.starred_url?.pathWithoutParameters() else {
                fatalError()
            }
            return URL(string: path)!
        case .followers(let user), .subscriptions(let user), .organizations(let user), .repositories(let user):
            return user.followers_url!
        case .myProfile:
            return  URL(string: "https://api.github.com/user")!
        }
        
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var headers: RequestHeaders {
        return Endpoint.defaultHeaders
    }
    
    var parameters: RequestParameters {
        return [:]
    }
    
    var jsonBody: Data? {
        return nil
    }
}
