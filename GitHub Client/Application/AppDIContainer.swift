//
//  AppDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class AppDIContainer {

    static let shared = AppDIContainer()

    private init() {}

    lazy var appConfiguration = AppConfiguration()

    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        let networkService = NetworkServiceImpl(config: config)
        return DataTransferServiceImpl(with: networkService)
    }()

    lazy var favoritesStorage: FavoritesStorage = {
        let favoritesStorage = FavoritesStorageImpl()
        return favoritesStorage
    }()

    // MARK: - DIContainers of scenes
    func makeTabCoordinator(window: UIWindow,
                            dependencies: MainSceneDIContainer.Dependencies) -> MainCoordinator {
        let container = MainSceneDIContainer(appDIContainer: self, dependencies: dependencies)
        return MainCoordinator.init(in: window, mainSceneDIContainer: container)
    }

    func makeLoginSceneDIContainer(
        dependencies: LoginSceneDIContainer.Dependencies) -> LoginSceneDIContainer {
        return LoginSceneDIContainer(dependencies: dependencies)
    }
}
