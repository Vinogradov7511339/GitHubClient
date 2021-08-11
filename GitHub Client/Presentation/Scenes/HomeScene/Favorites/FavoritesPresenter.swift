//
//  FavoritesPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

protocol FavoritesPresenterInput {
    var output: FavoritesPresenterOutput? { get set }
    
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

protocol FavoritesPresenterOutput: AnyObject {
    func display(viewModels: [[Any]])
    func updateTableView(deletedObjects: [IndexPath], insertedObjects: [IndexPath], viewModels: [[Any]])
}

class FavoritesPresenter {
    var output: FavoritesPresenterOutput?
    
    var favorites: [RepositoryResponseDTO] = []
    var notFavorites: [RepositoryResponseDTO] = []
}


// MARK: - FavoritesPresenterInput
extension FavoritesPresenter: FavoritesPresenterInput {
    func viewDidLoad() {
        fetchRepositories()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let isRemoving = indexPath.section == 0
        let insertedIndex: Int
        if isRemoving {
//            storage.remove(favorites[indexPath.row])
            let removed = favorites.remove(at: indexPath.row)
            notFavorites.insert(removed, at: 0)
            insertedIndex = 0
        } else {
//            storage.add(notFavorites[indexPath.row])
            let added = notFavorites.remove(at: indexPath.row)
            favorites.append(added)
            insertedIndex = favorites.count - 1
        }
        let section = indexPath.section == 0 ? 1 : 0
        let toIndexPath = IndexPath(row: insertedIndex, section: section)

        let mappedFavorites = favorites.map { map($0, isFavorite: true) }
        let mappedNotFavorites = notFavorites.map { map($0, isFavorite: false) }
        let viewModels = [mappedFavorites, mappedNotFavorites]
        
        output?.updateTableView(deletedObjects: [indexPath], insertedObjects: [toIndexPath], viewModels: viewModels)
    }
}

// MARK: - private
private extension FavoritesPresenter {
    func fetchRepositories() {
    }
    
    func map(_ repository: RepositoryResponseDTO, isFavorite: Bool) -> FavoriteRepositoryCellViewModel {
        fatalError()
        let imageName = isFavorite ? "xmark.circle.fill" : "plus.circle"
        let tintColor: UIColor = isFavorite ? .systemGray : .link
        let image = UIImage(systemName: imageName)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
//        return FavoriteRepositoryCellViewModel(
//            image: image,
//            repository: repository
//        )
    }
    
    func filterRepositories(_ repositories: [RepositoryResponseDTO]) {
        favorites = []
        notFavorites = []

        for repository in repositories {
//            if storage.contains(repository) {
                favorites.append(repository)
//            } else {
                notFavorites.append(repository)
//            }
        }

        let mappedFavorites = favorites.map { map($0, isFavorite: true) }
        let mappedNotFavorites = notFavorites.map { map($0, isFavorite: false) }
        self.output?.display(viewModels: [mappedFavorites, mappedNotFavorites])
    }
}
