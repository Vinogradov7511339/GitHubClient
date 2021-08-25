//
//  LoginSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class NotLoggedSceneDIContainer: NSObject {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let searchFilterStorage: SearchFilterStorage
        let exploreSettingsStorage: ExploreSettingsStorage

        var userLoggedIn: () -> Void
        var openSettings: (UINavigationController) -> Void
        let openRepository: (Repository, UINavigationController) -> Void
        let openUser: (User, UINavigationController) -> Void
        let openIssue: (Issue, UINavigationController) -> Void
        let openPullRequest: (PullRequest, UINavigationController) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let loginFactory: LoginFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.loginFactory = LoginFactoryImpl(dataTransferService: dependencies.dataTransferService)
    }
}

// MARK: - NotLoggedFlowCoordinatorDependencies
extension NotLoggedSceneDIContainer: NotLoggedFlowCoordinatorDependencies {
    func tabBar() -> UITabBarController {
        let controller = UITabBarController()
        controller.delegate = self
        controller.tabBar.isTranslucent = false
        return controller
    }

    func configure(_ controller: UITabBarController) {
        controller.setViewControllers(controllers(), animated: true)
        controller.selectedIndex = 0
    }

    private func controllers() -> [UIViewController] {
        TabBarPage.allCases.map { controller(for: $0) }
    }

    private func controller(for type: TabBarPage) -> UINavigationController {
        let navigation = UINavigationController()
        navigation.tabBarItem = UITabBarItem(title: type.title, image: type.image, tag: type.rawValue)
        switch type {
        case .explore:
            let container = ExploreDIContainer(exploreDependencies())
            let explore = ExploreFlowCoordinator(with: container, in: navigation)
            explore.start()
        case .signIn:
            let container = SignInDIContainer(signInDependencies())
            let signIn = SignInFlowCoordinator(navigation, dependencies: container)
            signIn.start()
        }
        return navigation
    }

    func userLoggedIn() {
        dependencies.userLoggedIn()
    }

    // MARK: - Login flow

    func makeLoginViewController(actions: LoginViewModelActions) -> UIViewController {
        loginFactory.makeLoginViewController(actions: actions)
    }
}

// MARK: - Containers
private extension NotLoggedSceneDIContainer {
    func exploreDependencies() -> ExploreDIContainer.Dependencies {
        .init(dataTransferService: dependencies.dataTransferService,
              searchFilterStorage: dependencies.searchFilterStorage,
              exploreSettingsStorage: dependencies.exploreSettingsStorage,
              showRepository: dependencies.openRepository,
              showIssue: dependencies.openIssue,
              showPullRequest: dependencies.openPullRequest,
              showUser: dependencies.openUser)
    }

    func signInDependencies() -> SignInDIContainer.Dependencies {
        .init(dataTransferService: dependencies.dataTransferService,
              login: dependencies.userLoggedIn,
              openSettings: dependencies.openSettings)
    }
}

// MARK: - Tabbar
private extension NotLoggedSceneDIContainer {
    enum TabBarPage: Int, CaseIterable {
        case explore
        case signIn

        var title: String {
            switch self {
            case .explore:
                return NSLocalizedString("Explore", comment: "")
            case .signIn:
                return NSLocalizedString("Sign In", comment: "")

            }
        }

        var image: UIImage? {
            switch self {
            case .explore:
                return UIImage.TabBar.explore
            case .signIn:
                return UIImage.TabBar.signIn
            }
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension NotLoggedSceneDIContainer: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
