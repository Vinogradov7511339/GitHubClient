//
//  HomeDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

final class HomeDIContainer {
    struct Dependencies {
        let apiDataTransferService: DataTransferService

        var showOrganizations: () -> Void
        var showRepositories: () -> Void
        var showRepository: (Repository) -> Void
        var showEvent: (Issue) -> Void
    }

    let dependencies: Dependencies
    private let homeSceneFactory: HomeSceneFactory
    private let myFavoritesStorage = MyFavoritesStorageImpl()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.homeSceneFactory = HomeSceneFactoryImpl(dataTransferService: dependencies.apiDataTransferService, storage: myFavoritesStorage)
    }

    func createHomeViewController(actions: HomeActions) -> HomeViewController {
        homeSceneFactory.makeHomeViewController(actions)
    }
}
