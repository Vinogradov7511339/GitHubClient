//
//  RepSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class RepSceneDIContainer {

    struct Dependencies {
        let favoritesStorage: FavoritesStorage
        let repository: Repository
        var startUserFlow: (User) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
    }

    private let dependencies: Dependencies
    private let factory: ExtendedRepositoryFactory

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        factory = ExtendedRepositoryFactoryImpl(repository: dependencies.repository,
                                                favoriteStorage: dependencies.favoritesStorage)
    }

    func makeRepFlowCoordinator(in navigationController: UINavigationController) -> RepFlowCoordinator {
        return .init(navigationController: navigationController, dependencies: self)
    }
}

extension RepSceneDIContainer: RepFlowCoordinatorDependencies {
    func startUserFlow(with user: User) {
        dependencies.startUserFlow(user)
    }

    func openLink(url: URL) {
        dependencies.openLink(url)
    }

    func share(url: URL) {
        dependencies.share(url)
    }

    // MARK: - Rep flow

    func makeRepViewController(actions: RepActions) -> RepViewController {
        factory.makeExtendedRepositoryViewController(actions: actions)
    }
}
