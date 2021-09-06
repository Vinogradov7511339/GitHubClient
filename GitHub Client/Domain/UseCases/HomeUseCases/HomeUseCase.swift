//
//  HomeUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

protocol HomeUseCase {
    func fetchWidgets(completion: @escaping (Result<[HomeWidget], Error>) -> Void)
    func fetchFavorites(completion: @escaping (Result<[Repository], Error>) -> Void)

    typealias EventsHandler = (Result<ListResponseModel<Event>, Error>) -> Void
    func fetchEvents(completion: @escaping EventsHandler)

    typealias IssuesHandler = (Result<ListResponseModel<Issue>, Error>) -> Void
    func fetchIssues(_ page: Int, completion: @escaping IssuesHandler)
}

final class HomeUseCaseImpl {

    let repository: MyProfileRepository
    let issuesFilterStorage: IssueFilterStorage

    init(repository: MyProfileRepository, issuesFilterStorage: IssueFilterStorage) {
        self.repository = repository
        self.issuesFilterStorage = issuesFilterStorage
    }
}

// MARK: - HomeUseCase
extension HomeUseCaseImpl: HomeUseCase {
    func fetchWidgets(completion: @escaping (Result<[HomeWidget], Error>) -> Void) {
        repository.fetchWidgets(completion: completion)
    }

    func fetchFavorites(completion: @escaping (Result<[Repository], Error>) -> Void) {
        completion(.success([]))
    }

    func fetchEvents(completion: @escaping EventsHandler) {
        repository.fetchProfile { result in
            switch result {
            case .success(let user):
                let eventsUrl = user.userDetails.eventsUrl
                self.fetchLastEvents(eventsUrl, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchIssues(_ page: Int, completion: @escaping IssuesHandler) {
        guard let path = URL(string: "https://api.github.com/user/issues") else {
            completion(.failure(MapError())) // todo
            return
        }
        let filter = issuesFilterStorage.filter(for: .custom)
        let model = IssuesRequestModel(page: page, path: path, filter: filter)
        repository.fetchIssues(request: model, completion: completion)
    }
}

// MARK: - Private
private extension HomeUseCaseImpl {
    func fetchLastEvents(_ path: URL, completion: @escaping EventsHandler) {
        let model = EventsRequestModel(path: path, page: 1, perPage: 10)
        repository.fetchEvents(request: model, completion: completion)
    }
}
