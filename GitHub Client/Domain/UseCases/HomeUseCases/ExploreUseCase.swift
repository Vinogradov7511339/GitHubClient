//
//  ExploreUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

struct NarrowFilterError: Error {
    let filterType: SearchFilter.FilterType
    let filter: SearchFilter
}

protocol ExploreUseCase {

    // MARK: - Repositories

    typealias RepositoriesHandler = ExploreTempRepository.RepositoriesHandler
    func mostStarred(_ model: SearchRequestModel, completion: @escaping RepositoriesHandler)
    func searchRepositoryByName(_ name: String, page: Int, completion: @escaping RepositoriesHandler)

    // MARK: - Issues

    typealias IssuesHandler = ExploreTempRepository.IssuesHandler
    func searchIssueByLabel(_ name: String, page: Int, completion: @escaping IssuesHandler)

    // MARK: - PullRequests

    typealias PullRequestsHandler = (Result<SearchResponseModel, Error>) -> Void
    func searchPullRequests(_ name: String, page: Int, completion: @escaping PullRequestsHandler)

    // MARK: - Users

    typealias UsersHandler = ExploreTempRepository.UsersHandler
    func searchUsersByName(_ name: String, page: Int, completion: @escaping UsersHandler)

    // MARK: - All

    typealias AllResultsTuple = [SearchType: SearchResponseModel]
    typealias AllResultHandler = (Result<AllResultsTuple, Error>) -> Void
    func searchAllTypesByName(_ searchText: String, completion: @escaping AllResultHandler)
}

final class ExploreUseCaseImpl {

    private let searchFilter: SearchFilter
    private let exploreRepository: ExploreTempRepository
    private let dispatchGroup = DispatchGroup()

    init(searchFilter: SearchFilter, exploreRepository: ExploreTempRepository) {
        self.searchFilter = searchFilter
        self.exploreRepository = exploreRepository
    }
}

// MARK: - ExploreTempUseCase
extension ExploreUseCaseImpl: ExploreUseCase {
    func mostStarred(_ model: SearchRequestModel, completion: @escaping RepositoriesHandler) {
//        let text = "stars:>10000"
//        let searchModel = SearchRequestModel(searchType: .repositories, searchText: text)
        exploreRepository.fetchRepositories(model, completion: completion)
    }

    func searchRepositoryByName(_ name: String, page: Int, completion: @escaping RepositoriesHandler) {
        let query = searchFilter.repositoriesSearchParameters.parameter(name)
        let model = SearchRequestModel(searchType: .repositories,
                                       searchText: query,
                                       perPage: 20,
                                       page: page)
        exploreRepository.fetchRepositories(model) { result in
            switch result {
            case .success(let model):
                self.checkFilters(.repositories, page: page, model: model, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchIssueByLabel(_ name: String, page: Int, completion: @escaping IssuesHandler) {
        let query = searchFilter.issuesSearchParameters.parameter(name)
        let model = SearchRequestModel(searchType: .issues,
                                       searchText: query,
                                       perPage: 20,
                                       page: page)
        exploreRepository.fetchIssues(model) { result in
            switch result {
            case .success(let model):
                self.checkFilters(.issues, page: page, model: model, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchPullRequests(_ name: String, page: Int, completion: @escaping PullRequestsHandler) {
        let query = searchFilter.pullReqestsSearchParameters.parameter(name)
        let model = SearchRequestModel(searchType: .pullRequests,
                                       searchText: query,
                                       perPage: 20,
                                       page: page)
        exploreRepository.fetchPullRequests(model) { result in
            switch result {
            case .success(let model):
                self.checkFilters(.pullRequests, page: page, model: model, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchUsersByName(_ name: String, page: Int, completion: @escaping UsersHandler) {
        let query = searchFilter.usersSearchParameters.parameter(name)
        let model = SearchRequestModel(searchType: .users,
                                       searchText: query,
                                       perPage: 20,
                                       page: page)
        exploreRepository.fetchUsers(model) { result in
            switch result {
            case .success(let model):
                self.checkFilters(.people, page: page, model: model, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchAllTypesByName(_ searchText: String, completion: @escaping AllResultHandler) {
        fetchAll(searchText, completion: completion)
    }
}

// MARK: - Handle Empty results
private extension ExploreUseCaseImpl {
    func checkFilters(_ filterType: SearchFilter.FilterType,
                      page: Int,
                      model: SearchResponseModel,
                      completion: @escaping (Result<SearchResponseModel, Error>) -> Void) {
        guard model.items.isEmpty && page > 1 else {
            completion(.success(model))
            return
        }
        switch filterType {
        case .repositories:
            if searchFilter.repositoriesSearchParameters == .all {
                completion(.success(model))
                return
            }
        case .issues:
            if searchFilter.issuesSearchParameters == .all {
                completion(.success(model))
                return
            }
        case .pullRequests:
            if searchFilter.pullReqestsSearchParameters == .all {
                completion(.success(model))
                return
            }
        case .people:
            if searchFilter.usersSearchParameters == .all {
                completion(.success(model))
                return
            }
        }
        let narrowFilterError = NarrowFilterError(filterType: filterType, filter: searchFilter)
        completion(.failure(narrowFilterError))
    }
}

// MARK: - Private
private extension ExploreUseCaseImpl {
    func fetchAll(_ searchText: String, completion: @escaping AllResultHandler) {
        var repositories: SearchResponseModel?
        var issues: SearchResponseModel?
        var pullRequests: SearchResponseModel?
        var users: SearchResponseModel?

        var searchErrors: [Error] = []

        dispatchGroup.enter()
        dispatchGroup.enter()
        dispatchGroup.enter()
        dispatchGroup.enter()

        dispatchGroup.notify(queue: .main) {
            let repModel: SearchResponseModel
            if let repositories = repositories {
                repModel = repositories
            } else {
                repModel = SearchResponseModel(itemsType: .repository([]), lastPage: 1, total: 0)
            }

            let issuesModel: SearchResponseModel
            if let issues = issues {
                issuesModel = issues
            } else {
                issuesModel = SearchResponseModel(itemsType: .issue([]), lastPage: 1, total: 0)
            }

            let pullRequestModel: SearchResponseModel
            if let pullRequests = pullRequests {
                pullRequestModel = pullRequests
            } else {
                pullRequestModel = SearchResponseModel(itemsType: .pullRequest([]), lastPage: 1, total: 0)
            }

            let usersModel: SearchResponseModel
            if let users = users {
                usersModel = users
            } else {
                usersModel = SearchResponseModel(itemsType: .users([]), lastPage: 1, total: 0)
            }

            let result: [SearchType: SearchResponseModel] = [
                .repositories: repModel,
                .issues: issuesModel,
                .pullRequests: pullRequestModel,
                .people: usersModel,
            ]
            completion(.success(result))
        }

        searchRepositoryByName(searchText, page: 1) { result in
            switch result {
            case .success(let response):
                repositories = response
            case .failure(let error):
                searchErrors.append(error)
            }
            self.dispatchGroup.leave()
        }

        searchIssueByLabel(searchText, page: 1) { result in
            switch result {
            case .success(let response):
                issues = response
            case .failure(let error):
                searchErrors.append(error)
            }
            self.dispatchGroup.leave()
        }

        searchPullRequests(searchText, page: 1) { result in
            switch result {
            case .success(let response):
                pullRequests = response
            case .failure(let error):
                searchErrors.append(error)
            }
            self.dispatchGroup.leave()
        }

        searchUsersByName(searchText, page: 1) { result in
            switch result {
            case .success(let response):
                users = response
            case .failure(let error):
                searchErrors.append(error)
            }
            self.dispatchGroup.leave()
        }
    }
}
