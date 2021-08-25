//
//  HomeDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

final class HomeDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let favoritesStorage: FavoritesStorage
        let profileStorage: ProfileLocalStorage
    }


    // MARK: - Private variables

    private let dependencies: Dependencies
    private let homeSceneFactory: HomeSceneFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.homeSceneFactory = HomeSceneFactoryImpl(
            dataTransferService: dependencies.dataTransferService,
            favoritesStorage: dependencies.favoritesStorage,
            profileStorage: dependencies.profileStorage)
    }
}

// MARK: - HomeFlowCoordinatorDependencies
extension HomeDIContainer: HomeFlowCoordinatorDependencies {
    func homeViewController(_ actions: HomeActions) -> UIViewController {
        homeSceneFactory.homeViewController(actions)
    }
}
