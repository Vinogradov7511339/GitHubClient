//
//  LoginSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

final class LoginSceneDIContainer: NSObject {
    
    struct Dependencies {
        let dataTransferService: DataTransferService
        var userLoggedIn: () -> Void
        var openSettings: (UINavigationController) -> Void

        let showRepository: (Repository) -> Void
        let showIssue: (Issue) -> Void
        let showPullRequest: (PullRequest) -> Void
        let showUser: (User) -> Void
        let showOrganization: (Organization) -> Void
    }

    let dependencies: Dependencies
    private let loginFactory: LoginFactory

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.loginFactory = LoginFactoryImpl(dataTransferService: dependencies.dataTransferService)
    }

    func makeLoginFlowCoordinator(in window: UIWindow) -> LoginFlowCoordinator {
        return LoginFlowCoordinator(in: window, dependencies: self)
    }
}

// MARK: - LoginFlowCoordinatorDependencies
extension LoginSceneDIContainer: LoginFlowCoordinatorDependencies {
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
            let dependencies = ExploreDIContainer.Dependencies(
                dataTransferService: dependencies.dataTransferService,
                showRepository: dependencies.showRepository,
                showIssue: dependencies.showIssue,
                showPullRequest: dependencies.showPullRequest,
                showUser: dependencies.showUser,
                showOrganization: dependencies.showOrganization)

            let container = ExploreDIContainer(dependencies)
            let explore = ExploreFlowCoordinator(navigation, dependencies: container)
            explore.start()
        case .signIn:
            let dependencies = SignInDIContainer.Dependencies(
                dataTransferService: dependencies.dataTransferService,
                login: dependencies.userLoggedIn,
                openSettings: dependencies.openSettings)
            let container = SignInDIContainer(dependencies)
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
extension LoginSceneDIContainer: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
