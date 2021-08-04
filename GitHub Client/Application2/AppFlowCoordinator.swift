//
//  AppFlowCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class AppFlowCoordinator {
    
    private let navigation: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigation: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigation = navigation
        self.appDIContainer = appDIContainer
    }
    
    func start(login: String) {
        //todo add login logic
        let starredSceneDIContainer = appDIContainer.makeStarredSceneDIContainer(login: login)
        let flow = starredSceneDIContainer.makeStarredFlowCoordinator(navigationConroller: navigation)
        flow.start()
    }
}
