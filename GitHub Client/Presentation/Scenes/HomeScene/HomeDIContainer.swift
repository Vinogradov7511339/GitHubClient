//
//  HomeDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

final class HomeDIContainer {
    struct Actions {
    }

    let actions: Actions
    private let homeSceneFactory: HomeSceneFactory

    init(parentContainer: MainSceneDIContainer, actions: Actions) {
        self.actions = actions
        self.homeSceneFactory = HomeSceneFactoryImpl(
            dataTransferService: parentContainer.apiDataTransferService,
            favoritesStorage: parentContainer.favoritesStorage,
            profileStorage: parentContainer.profileStorage)
    }

    func homeViewController(actions: HomeActions) -> UIViewController {
        homeSceneFactory.homeViewController(actions)
    }

    func issuesViewController() -> UIViewController {
        homeSceneFactory.myIssuesViewController()
    }
}
