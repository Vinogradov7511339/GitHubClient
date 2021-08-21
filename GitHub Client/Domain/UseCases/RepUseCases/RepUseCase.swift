//
//  RepUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepUseCase {
    typealias RepHandler = RepRepository.RepHandler
    func fetchRepository(repository: Repository, completion: @escaping (Result<RepositoryDetails, Error>) -> Void)

    // MARK: - Branches

    typealias BranchesHandler = RepRepository.BranchesHandler
    func fetchBranches(request: BranchesRequestModel, completion: @escaping BranchesHandler)

    // MARK: - Content

    typealias ContentHandler = RepRepository.ContentHandler
    func fetchContent(path: URL, completion: @escaping ContentHandler)

    typealias FileHandler = RepRepository.FileHandler
    func fetchFile(path: URL, completion: @escaping FileHandler)
    func fetchReadMe(repository: Repository, completion: @escaping FileHandler)  

    // MARK: - Releases

    typealias ReleasesHandler = RepRepository.ReleasesHandler
    func fetchReleases(request: ReleasesRequestModel, completion: @escaping ReleasesHandler)

    typealias ReleaseHandler = RepRepository.ReleaseHandler
    func fetchRelease(request: ReleaseRequestModel, completion: @escaping ReleaseHandler)

    // MARK: - License

    typealias LicenseHandler = RepRepository.LicenseHandler
    func fetchLicense(request: LicenseRequestModel, completion: @escaping LicenseHandler)

    // MARK: - Watchers

    typealias WatchersHandler = RepRepository.WatchersHandler
    func fetchWatchers(request: WatchersRequestModel, completion: @escaping WatchersHandler)

    // MARK: - Forks

    typealias ForksHandler = RepRepository.ForksHandler
    func fetchForks(request: ForksRequestModel, completion: @escaping ForksHandler)
}

class RepUseCaseImpl {

    let repositoryStorage: RepRepository
    let repositoryFacade: RepositoryFacade

    init(repositoryStorage: RepRepository,
         repositoryFacade: RepositoryFacade) {
        self.repositoryStorage = repositoryStorage
        self.repositoryFacade = repositoryFacade
    }
}

// MARK: - RepUseCase
extension RepUseCaseImpl: RepUseCase {

    func fetchRepository(repository: Repository, completion: @escaping (Result<RepositoryDetails, Error>) -> Void) {
        repositoryStorage.fetchRepository(repository: repository) { result in
            switch result {
            case .success(let repository):
                self.repositoryFacade.fetchDetails(repository: repository, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

    func fetchBranches(request: BranchesRequestModel, completion: @escaping BranchesHandler) {
        repositoryStorage.fetchBranches(request: request, completion: completion)
    }

    func fetchContent(path: URL, completion: @escaping ContentHandler) {
        repositoryStorage.fetchContent(path: path, completion: completion)
    }

    func fetchFile(path: URL, completion: @escaping FileHandler) {
        repositoryStorage.fetchFile(path: path, completion: completion)
    }

    func fetchReadMe(repository: Repository, completion: @escaping FileHandler) {
        repositoryStorage.fetchReadMe(repository: repository, completion: completion)
    }

    func fetchReleases(request: ReleasesRequestModel, completion: @escaping ReleasesHandler) {
        repositoryStorage.fetchReleases(request: request, completion: completion)
    }

    func fetchRelease(request: ReleaseRequestModel, completion: @escaping ReleaseHandler) {
        repositoryStorage.fetchRelease(request: request, completion: completion)
    }

    func fetchLicense(request: LicenseRequestModel, completion: @escaping LicenseHandler) {
        repositoryStorage.fetchLicense(request: request, completion: completion)
    }

    func fetchWatchers(request: WatchersRequestModel, completion: @escaping WatchersHandler) {
        repositoryStorage.fetchWatchers(request: request, completion: completion)
    }

    func fetchForks(request: ForksRequestModel, completion: @escaping ForksHandler) {
        repositoryStorage.fetchForks(request: request, completion: completion)
    }
}
