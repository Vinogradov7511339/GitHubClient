//
//  FavoritesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 11.08.2021.
//

import UIKit

protocol FavoritesViewModelInput {
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

protocol FavoritesViewModelOutput {
    typealias UpdatedItems = (deletedObjects: [IndexPath], insertedObjects: [IndexPath], viewModels: [[Any]])

    var models: Observable<[[FavoriteRepositoryCellViewModel]]> { get }
    var updates: Observable<UpdatedItems> { get }
}

typealias FavoritesViewModel = FavoritesViewModelInput & FavoritesViewModelOutput

final class FavoritesViewModelImpl: FavoritesViewModel {

    // MARK: - Output

    var models: Observable<[[FavoriteRepositoryCellViewModel]]> = Observable([[]])
    var updates: Observable<UpdatedItems> = Observable(([], [], [[]]))

    // MARK: - Private

    private let useCase: FavoritesUseCase
    private var favorites: [Repository] = []
    private var notFavorites: [Repository] = []

    init(useCase: FavoritesUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Input
extension FavoritesViewModelImpl {
    func viewDidLoad() {
        useCase.fetchRepositories { result in
            switch result {
            case .success(let repositories):
                self.favorites = repositories.favorites
                self.notFavorites = repositories.notFavorites
                let mappedFavorites = self.favorites.map { self.map($0, isFavorite: true) }
                let mappedNotFavorites = self.notFavorites.map { self.map($0, isFavorite: false) }
                self.models.value = [mappedFavorites, mappedNotFavorites]
            case .failure(let error):
                self.handle(error)
            }
        }
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

        updates.value = (deletedObjects: [indexPath], insertedObjects: [toIndexPath], viewModels: viewModels)
    }
}

// MARK: - Private
private extension FavoritesViewModelImpl {
    func map(_ repository: Repository, isFavorite: Bool) -> FavoriteRepositoryCellViewModel {
        let imageName = isFavorite ? "xmark.circle.fill" : "plus.circle"
        let tintColor: UIColor = isFavorite ? .systemGray : .link
        let image = UIImage(systemName: imageName)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        return FavoriteRepositoryCellViewModel(
            image: image,
            repository: repository
        )
    }

    func handle(_ error: Error) {}
}
