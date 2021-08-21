//
//  HomeSceneFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol HomeSceneFactory {
    func homeViewController(_ actions: HomeActions) -> UIViewController
    func myIssuesViewController() -> UIViewController
}

final class HomeSceneFactoryImpl {
    private let dataTransferService: DataTransferService
    private let favoritesStorage: FavoritesStorage
    private let profileStorage: ProfileLocalStorage

    init(dataTransferService: DataTransferService,
         favoritesStorage: FavoritesStorage,
         profileStorage: ProfileLocalStorage) {
        self.dataTransferService = dataTransferService
        self.favoritesStorage = favoritesStorage
        self.profileStorage = profileStorage
    }
}

// MAK: - HomeSceneFactory
extension HomeSceneFactoryImpl: HomeSceneFactory {
    func homeViewController(_ actions: HomeActions) -> UIViewController {
        HomeVC.create(with: createHomeViewModel(actions: actions))
    }

    func myIssuesViewController() -> UIViewController {
        MyIssuesViewController()
    }
}

private extension HomeSceneFactoryImpl {
    func createHomeViewModel(actions: HomeActions) -> HomeViewModel {
        HomeViewModelImpl(useCase: homeUseCase, actions: actions)
    }
    
    var homeUseCase: HomeUseCase {
        HomeUseCaseImpl(repository: profileRepository, favoritesStorage: favoritesStorage)
    }

    var profileRepository: MyProfileRepository {
        MyProfileRepositoryImpl(dataTransferService: dataTransferService, localStorage: profileStorage)
    }
}
