//
//  AppDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class AppDIContainer {

    // MARK: - DIContainers of scenes
    func makeTabCoordinator(window: UIWindow, dependencies: MainSceneCoordinatorDependencies) -> MainCoordinator {
        let container = MainSceneDIContainer(dependencies: dependencies)
        return MainCoordinator.init(in: window, mainSceneDIContainer: container)
    }
    
    func makeLoginSceneDIContainer(dependencies: LoginSceneDIContainer.Dependencies) -> LoginSceneDIContainer {
        return LoginSceneDIContainer(dependencies: dependencies)
    }
}
