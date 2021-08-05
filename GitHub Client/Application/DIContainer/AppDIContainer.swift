//
//  AppDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class AppDIContainer {

    // MARK: - DIContainers of scenes
    func makeTabCoordinator(window: UIWindow) -> TabCoordinator {
        return TabCoordinator.init(in: window)
    }
    
    func makeLoginSceneDIContainer(dependencies: LoginSceneDIContainer.Dependencies) -> LoginSceneDIContainer {
        return LoginSceneDIContainer(dependencies: dependencies)
    }

    func makeStarredSceneDIContainer(dependencies: UserSceneDIContainer.Dependencies) -> UserSceneDIContainer {
        return UserSceneDIContainer(dependencies: dependencies)
    }

    func makeRepSceneDIContainer(dependencies: RepSceneDIContainer.Dependencies) -> RepSceneDIContainer {
        return RepSceneDIContainer(dependencies: dependencies)
    }
}
