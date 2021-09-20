//
//  ListRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.08.2021.
//

import Foundation

final class ListRepositoryImpl {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ListRepository
extension ListRepositoryImpl: ListRepository {
    func fetchUsers(page: Int, _ url: URL, completion: @escaping UsersHandler) {
        var params: QueryType = [:]
        params["page"] = "\(page)"
        let endpoint = Endpoint<[UserResponseDTO]>(path: url.absoluteString,
                                                   isFullPath: true,
                                                   queryParametersEncodable: params)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let users = response.model.map { $0.toDomain() }
                let model = ListResponseModel<User>(users, response: response.httpResponse)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchRepositories(_ requestModel: ListRequestModel, completion: @escaping RepositoriesHandler) {
        var params: QueryType = [:]
        params["page"] = "\(requestModel.page)"
        let endpoint = Endpoint<[RepositoryResponseDTO]>(path: requestModel.path.absoluteString,
                                                   isFullPath: true,
                                                   queryParametersEncodable: params)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let repositories = response.model.compactMap { $0.toDomain() }
                let model = ListResponseModel<Repository>(repositories, response: response.httpResponse)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchBranches(_ requestModel: ListRequestModel, completion: @escaping BranchesHandler) {
        var params: QueryType = [:]
        params["page"] = "\(requestModel.page)"
        let endpoint = Endpoint<[BranchResponseDTO]>(path: requestModel.path.absoluteString,
                                                   isFullPath: true,
                                                   queryParametersEncodable: params)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let branches = response.model.map { $0.toDomain() }
                let model = ListResponseModel<Branch>(branches, response: response.httpResponse)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchReleases(_ requestModel: ListRequestModel, completion: @escaping ReleasesHandler) {
        var params: QueryType = [:]
        params["page"] = "\(requestModel.page)"
        let endpoint = Endpoint<[ReleaseResponseDTO]>(path: requestModel.path.absoluteString,
                                                   isFullPath: true,
                                                   queryParametersEncodable: params)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let releases = response.model.map { $0.toDomain() }
                let model = ListResponseModel<Release>(releases, response: response.httpResponse)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchCommits(_ requestModel: ListRequestModel, completion: @escaping CommitsHandler) {
        var params: QueryType = [:]
        params["page"] = "\(requestModel.page)"
        let endpoint = Endpoint<[CommitResponseDTO]>(path: requestModel.path.absoluteString,
                                                   isFullPath: true,
                                                   queryParametersEncodable: params)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let commits = response.model.map { $0.toDomain() }
                let model = ListResponseModel<Commit>(commits, response: response.httpResponse)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchEvents(_ requestModel: ListRequestModel, completion: @escaping EventsHandler) {
        var params: QueryType = [:]
        params["page"] = "\(requestModel.page)"
        let endpoint = Endpoint<[EventResponseDTO]>(path: requestModel.path.absoluteString,
                                                   isFullPath: true,
                                                   queryParametersEncodable: params)
        dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                let events = response.model.compactMap { $0.toDomain() }
                let model = ListResponseModel<Event>(events, response: response.httpResponse)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
