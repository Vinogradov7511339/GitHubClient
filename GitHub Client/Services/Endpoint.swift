//
//  Endpoint.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import Foundation

typealias RequestHeaders = [String: String]
typealias RequestParameters = [String: String]

protocol EndpointProtocol {
    var path: URL { get }
    var method: RequestMethod { get }
    var headers: RequestHeaders { get }
    var parameters: RequestParameters { get }
    var jsonBody: Data? { get }
}

enum Endpoint {
    case login(authCode: String)
    case myProfile
    case allIssue
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

extension Endpoint: EndpointProtocol {
    
    var path: URL {
        switch self {
        case .login(_): return URL(string: "https://github.com/login/oauth/access_token")!
        case .myProfile: return URL(string: "https://api.github.com/user")!
        case .allIssue: return URL(string: "https://api.github.com/issues")!
        case .mostPopularRepositories: return URL(string: "https://api.github.com/search/repositories")!
        case .search(let type, _):
            switch type {
            case .repositories: return URL(string: "https://github.com/search")!
            case .issues: return URL(string: "https://github.com/search")!
            case .organizations: return URL(string: "https://github.com/search")!
            case .people: return URL(string: "https://github.com/search")!
            case .pullRequests: return URL(string: "https://github.com/search")!
            case .all: return URL(string: "https://github.com/search")!
            }
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
    var headers: RequestHeaders {
        switch self {
        case .myProfile:
            var headers: [String: String] = [:]
            headers["Authorization"] = Self.authorizationHeader
//            headers.merge(casheHeaders, uniquingKeysWith: { (_, last) in last })
            return headers
        case .login:
            var headers: [String: String] = [:]
            headers["Accept"] = "application/json"
            return headers
        case .search(_, _):
            var headers: [String: String] = [:]
            headers["Authorization"] = Self.authorizationHeader
            headers["Accept"] = "application/vnd.github.v3.text-match+json"
            return headers
        default:
            return Self.defaultHeaders
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .myProfile:
            return [:]
        case .allIssue:
            return ["filter" : "all"]
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
            query["q"] = "GitHub in:readme user:vinogradov7511339"
//            query["type"] = type.rawValue
//            query["sort"] = "stars"
            return query
        }
    }
    
    var jsonBody: Data? {
        switch self {
        case .login(_):
            return parameters.percentEncoded()
        default:
            return nil
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

extension Endpoint {
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
    
    static var defaultHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Authorization"] = authorizationHeader
        headers["Accept"] = "application/vnd.github.v3+json"
        return headers
    }
    
    static var authorizationHeader: String {
        if let tokenResponse = UserStorage.shared.token {
            return "token \(tokenResponse.access_token)"
        } else {
            return ""
        }
    }
    
    var casheHeaders: [String: String] {
        var headers: [String: String] = [:]
        if let ifModifiedSince = string(forKey: lastModifiedDateKey) {
            headers["If-Modified-Since"] = ifModifiedSince
        }
        if let etag = string(forKey: ifNoneMatchKey) {
            headers["If-None-Match"] = etag
        }
        return headers
    }
    
    func string(forKey: String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }
    
    func set(_ value: Any, for key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
}
