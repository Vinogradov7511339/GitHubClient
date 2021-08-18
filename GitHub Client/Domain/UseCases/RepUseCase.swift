//
//  RepUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepUseCase {
    func fetch(repository: Repository, completion: @escaping (Result<String, Error>) -> Void)
    func fetchContents(path: URL, completion: @escaping (Result<[FolderItem], Error>) -> Void)
    func fetchFile(path: URL, completion: @escaping (Result<File, Error>) -> Void)
}

class RepUseCaseImpl {

    let favoritesStorage: FavoritesStorage
    let repositoryStorage: RepRepository

    init(favoritesStorage: FavoritesStorage, repositoryStorage: RepRepository) {
        self.favoritesStorage = favoritesStorage
        self.repositoryStorage = repositoryStorage
    }
}

// MARK: - RepUseCase
extension RepUseCaseImpl: RepUseCase {
    func fetch(repository: Repository, completion: @escaping (Result<String, Error>) -> Void) {
        repositoryStorage.fetchReadMe(repository: repository, completion: completion)
    }

    func fetchContents(path: URL, completion: @escaping (Result<[FolderItem], Error>) -> Void) {
        repositoryStorage.fetchContent(path: path, completion: completion)
    }

    func fetchFile(path: URL, completion: @escaping (Result<File, Error>) -> Void) {
        repositoryStorage.fetchFile(path: path, completion: completion)
    }
}
