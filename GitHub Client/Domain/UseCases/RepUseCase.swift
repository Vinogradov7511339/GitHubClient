//
//  RepUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepUseCase {
    func fetchRepository(repository: Repository, completion: @escaping (Result<RepositoryDetails, Error>) -> Void)
    func fetchContents(path: URL, completion: @escaping (Result<[FolderItem], Error>) -> Void)
    func fetchFile(path: URL, completion: @escaping (Result<File, Error>) -> Void)
    func fetchBranches(repository: Repository, completion: @escaping (Result<[Branch], Error>) -> Void)
}

class RepUseCaseImpl {

    let favoritesStorage: FavoritesStorage
    let repositoryStorage: RepRepository
    let repositoryFacade: RepositoryFacade

    init(favoritesStorage: FavoritesStorage,
         repositoryStorage: RepRepository,
         repositoryFacade: RepositoryFacade) {
        self.favoritesStorage = favoritesStorage
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

    func fetchContents(path: URL, completion: @escaping (Result<[FolderItem], Error>) -> Void) {
        repositoryStorage.fetchContent(path: path, completion: completion)
    }

    func fetchFile(path: URL, completion: @escaping (Result<File, Error>) -> Void) {
        repositoryStorage.fetchFile(path: path, completion: completion)
    }

    func fetchBranches(repository: Repository, completion: @escaping (Result<[Branch], Error>) -> Void) {
        repositoryStorage.fetchBranches(repository: repository, completion: completion)
    }
}
