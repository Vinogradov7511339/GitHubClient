//
//  AppDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

final class AppDIContainer {

    // MARK: - DIContainers of scenes
    func makeStarredSceneDIContainer(dependencies: UserSceneDIContainer.Dependencies) -> UserSceneDIContainer {
        return UserSceneDIContainer(dependencies: dependencies)
    }

    func makeRepSceneDIContainer(dependencies: RepSceneDIContainer.Dependencies) -> RepSceneDIContainer {
        return RepSceneDIContainer(dependencies: dependencies)
    }
}
