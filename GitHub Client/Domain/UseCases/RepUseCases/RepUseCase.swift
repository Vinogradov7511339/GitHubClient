//
//  RepUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepUseCase {
    typealias RepHandler = RepRepository.RepHandler
    func fetchRepository(_ url: URL,
                         completion: @escaping (Result<RepositoryDetails, Error>) -> Void)

    // MARK: - Content

    typealias ContentHandler = RepRepository.ContentHandler
    func fetchContent(path: URL, completion: @escaping ContentHandler)

    typealias FileHandler = RepRepository.FileHandler
    func fetchFile(path: URL, completion: @escaping FileHandler)
    func fetchReadMe(repository: Repository, completion: @escaping FileHandler)

    // MARK: - Releases

    typealias ReleaseHandler = RepRepository.ReleaseHandler
    func fetchRelease(_ rep: Repository, _ release: Release, completion: @escaping ReleaseHandler)

    // MARK: - License

    typealias LicenseHandler = RepRepository.LicenseHandler
    func fetchLicense(request: LicenseRequestModel, completion: @escaping LicenseHandler)
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

    func fetchRepository(_ url: URL,
                         completion: @escaping (Result<RepositoryDetails, Error>) -> Void) {
        repositoryStorage.fetchRepository(url) { result in
            switch result {
            case .success(let repository):
                self.repositoryFacade.fetchDetails(repository: repository, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
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

    func fetchRelease(_ rep: Repository, _ release: Release, completion: @escaping ReleaseHandler) {
        let model = ReleaseRequestModel(repository: rep, release: release)
        repositoryStorage.fetchRelease(request: model, completion: completion)
    }

    func fetchLicense(request: LicenseRequestModel, completion: @escaping LicenseHandler) {
        repositoryStorage.fetchLicense(request: request, completion: completion)
    }
}
