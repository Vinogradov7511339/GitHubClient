//
//  RepositoriesEndpoint.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.07.2021.
//

import Foundation
import Networking

enum RepositoriesEndpoint {
    case starred(login: String, repository: String)
    case allMyRepositories
    case userRepositories(login: String)
    case getRepository(owner: String, repository: String)
    
    case getForks(owner: String, repository: String)
    
    case getCommits(owner: String, repository: String)
    case getCommit(owner: String, repository: String, ref: String)
    
    case fetchPullRequestCount(repository: RepositoryResponse)
    case fetchReleasesCount(repository: RepositoryResponse)
    case fetchDiscussionsCount(repository: RepositoryResponse)
    case fetchCommitsCount(repository: RepositoryResponse)
    
    case fetchReadMe(repository: RepositoryResponse)
    case fetchPullRequests(repository: RepositoryResponse)
    case fetchReleases(repository: RepositoryResponse)
    case fetchDiscussions(repository: RepositoryResponse)
    case fetchCommits(repository: RepositoryResponse)
    case fetchBranches(repository: RepositoryResponse)
    
    case fetchContent(repository: RepositoryResponse)
}

extension RepositoriesEndpoint: EndpointProtocol {
    var path: URL {
        switch self {
        case .starred(let login, let repository): return URL(string: "https://api.github.com/repos/\(login)/\(repository)/stargazers")!
        case .allMyRepositories: return URL(string: "https://api.github.com/user/repos")!
        case .userRepositories(let login): return URL(string: "https://api.github.com/\(login)/repos")!
        case .getRepository(let owner,let repository): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)")!
            
        case .getForks(let owner, let repository): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)/forks")!
            
        case .getCommits(let owner, let repository): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)/commits")!
        case .getCommit(let owner, let repository, let ref): return URL(string: "https://api.github.com/repos/\(owner)/\(repository)/commits/\(ref)")!
            

        case .fetchReadMe(let repository):
            let owner = repository.owner!.login
            let repositoryName = repository.name!
            return URL(string: "https://api.github.com/repos/\(owner)/\(repositoryName)/readme")!
            
        case .fetchPullRequests(let repository):
            let owner = repository.owner!.login
            let repositoryName = repository.name!
            return  URL(string: "https://api.github.com/repos/\(owner)/\(repositoryName)/pulls")!
            
        case .fetchPullRequestCount(let repository):
            return RepositoriesEndpoint.fetchPullRequests(repository: repository).path
            
        case .fetchReleases(let repository):
            let owner = repository.owner!.login
            let repositoryName = repository.name!
            return  URL(string: "https://api.github.com/repos/\(owner)/\(repositoryName)/releases")!
            
        case .fetchReleasesCount(let repository):
            return RepositoriesEndpoint.fetchReleases(repository: repository).path
            
        case .fetchDiscussions(let repository):
            let owner = repository.owner!.login
            let repositoryName = repository.name!
            return  URL(string: "https://api.github.com/repos/\(owner)/\(repositoryName)/comments")!
            
        case .fetchDiscussionsCount(let repository):
            return RepositoriesEndpoint.fetchDiscussions(repository: repository).path
            
        case .fetchCommits(let repository):
            let owner = repository.owner!.login
            let repositoryName = repository.name!
            return  URL(string: "https://api.github.com/repos/\(owner)/\(repositoryName)/commits")!
            
        case .fetchCommitsCount(let repository):
            return RepositoriesEndpoint.fetchCommits(repository: repository).path
            
        case .fetchBranches(let repository):
            let owner = repository.owner!.login
            let repositoryName = repository.name!
            return  URL(string: "https://api.github.com/repos/\(owner)/\(repositoryName)/branches")!
            
        case .fetchContent(let repository):
            let owner = repository.owner!.login
            let repositoryName = repository.name!
            return  URL(string: "https://api.github.com/repos/\(owner)/\(repositoryName)/contents")!
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
        case .fetchPullRequestCount:
            var params: [String: String] = [:]
            params["per_page"] = "1"
            return params
        case .fetchReleasesCount:
            var params: [String: String] = [:]
            params["per_page"] = "1"
            return params
        case .fetchDiscussionsCount:
            var params: [String: String] = [:]
            params["per_page"] = "1"
            return params
        case .fetchCommitsCount:
            var params: [String: String] = [:]
            params["per_page"] = "1"
            return params
        default:
            return [:]
        }
    }
    
    var jsonBody: Data? {
        return nil
    }
}
