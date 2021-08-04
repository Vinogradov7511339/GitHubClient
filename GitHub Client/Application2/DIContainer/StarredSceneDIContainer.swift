//
//  StarredSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class StarredSceneDIContainer {
    
    private let login: String

    init(login: String) {
        self.login = login
    }
    
    // MARK: - Flow Coordinators
    func makeStarredFlowCoordinator(navigationConroller: UINavigationController) -> StarredFlowCoordinator {
        return StarredFlowCoordinator(navigationController: navigationConroller, dependencies: self)
    }
}

// MARK: - StarredFlowCoordinatorDependencies
extension StarredSceneDIContainer: StarredFlowCoordinatorDependencies {
    func makeStarredViewController(actions: StarredActions) -> StarredViewController {
        return StarredViewController.create(
            with: makeStarredViewModel(actions: actions))
    }
    
    func makeStarredViewModel(actions: StarredActions) -> StarredViewModel {
        return StarredViewModelImpl(starredUseCase: makeStarredUseCase(), actions: actions)
    }
    
    func makeStarredUseCase() -> StarredUseCase {
        return StarredUseCaseImpl(login: login, repository: makeStarredRepository())
    }
    
    func makeStarredRepository() -> StarredRepository {
        return StarredRepositoryImpl()
    }
}
