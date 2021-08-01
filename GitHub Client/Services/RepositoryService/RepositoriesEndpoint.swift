//
//  RepositoriesEndpoint.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import Foundation

enum RepositoriesEndpoint {
    case starred(login: String, repository: String)
    case allMyRepositories
    case userRepositories(login: String)
    case readMe(owner: String, repository: String)
    case getRepository(owner: String, repository: String)
    
    case getForks(owner: String, repository: String)
    
    case getCommits(owner: String, repository: String)
    case getCommit(owner: String, repository: String, ref: String)
}

extension RepositoriesEndpoint: EndpointProtocol {
    var path: URL {
        switch self {
        case .starred(let login, let repository): return URL(string: "https://api.github.com/repos/\(login)/\(repository)/stargazers")!
        case .allMyRepositories: return URL(string: "https://api.github.com/user/repos")!
        case .userRepositories(let login): return URL(string: "https://api.github.com/\(login)/repos")!
        case .readMe(let owner, let repository): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)/readme")!
        case .getRepository(let owner,let repository): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)")!
            
        case .getForks(let owner, let repository): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)/forks")!
            
        case .getCommits(let owner, let repository): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)/commits")!
        case .getCommit(let owner, let repository, let ref): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)/commits/\(ref)")!
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
