//
//  MyFavoritesStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation
import CoreData

protocol FavoritesStorage {
    func contains(_ repositoryId: Int) -> Bool
    func fetchFavorites(completion: @escaping (Result<[Repository], Error>) -> Void)
    func addFavorite(repository: Repository, completion: @escaping (Error?) -> Void)
    func removeFavorite(by repositoryId: Int, completion: @escaping (Error?) -> Void)
}

final class FavoritesStorageImpl {

    private let coreDataStorage: CoreDataStorage
    private var favorites: Set<Int> = []

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

// MARK: - MyFavoritesStorage
extension FavoritesStorageImpl: FavoritesStorage {
    func fetchFavorites (completion: @escaping (Result<[Repository], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = FavoriteCDEntity.fetchRequest()
                let result = try context.fetch(request).compactMap { $0.toDomain() }
                self.favorites = Set(result.map { $0.repositoryId })
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func addFavorite(repository: Repository, completion: @escaping (Error?) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let entity = FavoriteCDEntity(repository, insertInto: context)
                context.insert(entity)
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    func removeFavorite(by repositoryId: Int, completion: @escaping (Error?) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = FavoriteCDEntity.fetchRequest()
                request.predicate = NSPredicate(format: "repositoryId == \(repositoryId)")
                let results = try context.fetch(request).compactMap { $0 }
                results.forEach { context.delete($0) }
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    func contains(_ repositoryId: Int) -> Bool {
        favorites.contains(repositoryId)
    }
}

// MARK: - Private
private extension FavoritesStorageImpl {}
