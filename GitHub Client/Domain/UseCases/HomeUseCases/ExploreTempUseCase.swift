//
//  ExploreTempUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

protocol ExploreTempUseCase {

    // MARK: - Repositories

    typealias RepositoriesHandler = ExploreTempRepository.RepositoriesHandler
    func mostStarred(completion: @escaping RepositoriesHandler)
    func searchRepositoryByName(_ name: String, completion: @escaping RepositoriesHandler)

    // MARK: - Users
    typealias UsersHandler = ExploreTempRepository.UsersHandler
    func searchUsersByName(_ name: String, completion: @escaping UsersHandler)

    // MARK: - Issues
    typealias IssuesHandler = ExploreTempRepository.IssuesHandler
    func searchIssueByLabel(_ label: String, completion: @escaping IssuesHandler)

    // MARK: - All
    typealias AllResultsTuple = [SearchType: SearchResponseModel<Any>]
    typealias AllResultHandler = (Result<AllResultsTuple, Error>) -> Void
    func searchAllTypesByName(_ name: String, completion: @escaping AllResultHandler)
}

final class ExploreTempUseCaseImpl {

    private let exploreRepository: ExploreTempRepository
    private let dispatchGroup = DispatchGroup()

    init(exploreRepository: ExploreTempRepository) {
        self.exploreRepository = exploreRepository
    }
}

// MARK: - ExploreTempUseCase
extension ExploreTempUseCaseImpl: ExploreTempUseCase {
    func mostStarred(completion: @escaping RepositoriesHandler) {
        let text = "stars:>10000"
        let searchModel = SearchRequestModel(searchType: .repositories, searchText: text)
        exploreRepository.fetchRepositories(searchModel, completion: completion)
    }

    func searchRepositoryByName(_ name: String, completion: @escaping RepositoriesHandler) {
        let text = "\(name) in:name,description"
        let searchModel = SearchRequestModel(searchType: .repositories, searchText: text)
        exploreRepository.fetchRepositories(searchModel, completion: completion)
    }

    func searchUsersByName(_ name: String, completion: @escaping UsersHandler) {
        let text = "\(name) in:name"
        let searchModel = SearchRequestModel(searchType: .users, searchText: text)
        exploreRepository.fetchUsers(searchModel, completion: completion)
    }

    func searchIssueByLabel(_ label: String, completion: @escaping IssuesHandler) {
        let text = "\(label) in:title,body"
        let searchModel = SearchRequestModel(searchType: .issues, searchText: text)
        exploreRepository.fetchIssues(searchModel, completion: completion)
    }

    func searchAllTypesByName(_ name: String, completion: @escaping AllResultHandler) {
        fetchAll(name, completion: completion)
    }
}

// MARK: - Private
private extension ExploreTempUseCaseImpl {
    func fetchAll(_ name: String, completion: @escaping AllResultHandler) {
        var repositories: SearchResponseModel<Repository>?
        var issues: SearchResponseModel<Issue>?
        var pullRequests: SearchResponseModel<PullRequest>?
        var users: SearchResponseModel<User>?
        var organizations: SearchResponseModel<Organization>?

        var searchErrors: [Error] = []

        dispatchGroup.enter()
        dispatchGroup.enter()
        dispatchGroup.enter()

        dispatchGroup.notify(queue: .main) {
            let repModel: SearchResponseModel<Repository>
            if let repositories = repositories {
                repModel = repositories
            } else {
                repModel = SearchResponseModel<Repository>(items: [], lastPage: 1, total: 0)
            }

            let issuesModel: SearchResponseModel<Issue>
            if let issues = issues {
                issuesModel = issues
            } else {
                issuesModel = SearchResponseModel<Issue>(items: [], lastPage: 1, total: 0)
            }

            let pullRequestModel: SearchResponseModel<PullRequest>
            if let pullRequests = pullRequests {
                pullRequestModel = pullRequests
            } else {
                pullRequestModel = SearchResponseModel<PullRequest>(items: [], lastPage: 1, total: 0)
            }

            let usersModel: SearchResponseModel<User>
            if let users = users {
                usersModel = users
            } else {
                usersModel = SearchResponseModel<User>(items: [], lastPage: 1, total: 0)
            }

            let organizationsModel: SearchResponseModel<Organization>
            if let organizations = organizations {
                organizationsModel = organizations
            } else {
                organizationsModel = SearchResponseModel<Organization>(items: [], lastPage: 1, total: 0)
            }
            let result: [SearchType: SearchResponseModel<Any>] = [:
//                .repositories: repModel,
//                .issues: issuesModel,
//                .pullRequests: pullRequestModel,
//                .people: usersModel,
//                .organizations: organizationsModel
            ]
            completion(.success(result))
        }

        searchRepositoryByName(name) { result in
            switch result {
            case .success(let response):
                repositories = response
            case .failure(let error):
                searchErrors.append(error)
            }
            self.dispatchGroup.leave()
        }

        searchUsersByName(name) { result in
            switch result {
            case .success(let response):
                users = response
            case .failure(let error):
                searchErrors.append(error)
            }
            self.dispatchGroup.leave()
        }

        searchIssueByLabel(name) { result in
            switch result {
            case .success(let response):
                issues = response
            case .failure(let error):
                searchErrors.append(error)
            }
            self.dispatchGroup.leave()
        }
    }
}
