//
//  Endpoint.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import Foundation

enum Endpoint {
    case login(authCode: String)
    case myProfile
    case allIssue
    case repositories
    case mostPopularRepositories
    case search(type: SearchType, text: String)
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}


extension Endpoint {
    
    var path: URL {
        switch self {
        case .login(_):
            return URL(string: "https://github.com/login/oauth/access_token")!
        case .search(let type, _):
            return URL(string: "https://github.com/search")!
            
        default:
            fatalError()
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    var headers: [String: String] {
        switch self {
        case .myProfile:
            var headers: [String: String] = [:]
            headers["Authorization"] = authorizationHeader
            
//            if let ifModifiedSince = string(forKey: lastModifiedDateKey) {
//                headers["If-Modified-Since"] = ifModifiedSince
//            }
//
//            if let etag = string(forKey: ifNoneMatchKey) {
//                headers["If-None-Match"] = etag
//            }
            return headers
        case .login:
            var headers: [String: String] = [:]
            headers["Accept"] = "application/json"
            return headers
        default:
            return defaultHeaders
        }
    }
    
    
    
    var query: [String: String] {
        switch self {
        case .myProfile:
            return [:]
        case .allIssue:
            return ["filter" : "all"]
        case .repositories:
            return [:]
        case .mostPopularRepositories:
            var query: [String: String] = [:]
            query["q"] = "swift"
            query["sort"] = "stars"
            query["per_page"] = "20"
            return query
        case .login(let authCode):
            var query: [String: String] = [:]
            query["grant_type"] = "authorization_code"
            query["code"] = authCode
            query["client_id"] = GithubConstants.CLIENT_ID
            query["client_secret"] = GithubConstants.CLIENT_SECRET
            return query
        case .search(let type, let text):
            var query: [String: String] = [:]
            query["q"] = "user:\(text)"
            query["type"] = type.rawValue
//            query["sort"] = "stars"
            return query
        }
    }
    
    func setlastModifiedDate(_ value: String) {
        switch self {
        case .myProfile:
            set(value, for: lastModifiedDateKey)
        default:
            break
        }
    }
    
    func setIfNoneMatch(_ value: String) {
        switch self {
        case .myProfile:
            set(value, for: ifNoneMatchKey)
        default:
            break
        }
    }
}

private extension Endpoint {
    var lastModifiedDateKey: String {
        switch self {
        case .myProfile:
            return "profileLastModified"
        default:
            return ""
        }
    }
    
    
    var ifNoneMatchKey: String {
        switch self {
        case .myProfile:
            return "profileEtag"
        default:
            return ""
        }
    }
    
    var defaultHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Authorization"] = authorizationHeader
        headers["Accept"] = "application/vnd.github.v3+json"
        return headers
    }
    
    var authorizationHeader: String {
        if let token = UserStorage.shared.token {
            return "Bearer \(token)"
        } else {
            return ""
        }
    }
    
    func string(forKey: String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }
    
    func set(_ value: Any, for key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
}
