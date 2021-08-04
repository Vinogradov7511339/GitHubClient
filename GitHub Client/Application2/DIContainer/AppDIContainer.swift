//
//  AppDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

final class AppDIContainer {

    // MARK: - DIContainers of scenes
    func makeStarredSceneDIContainer(login: String) -> StarredSceneDIContainer {
        return StarredSceneDIContainer(login: login)
    }
}
