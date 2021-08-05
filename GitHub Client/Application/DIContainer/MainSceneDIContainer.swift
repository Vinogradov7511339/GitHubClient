//
//  MainSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

struct MainSceneCoordinatorDependencies {
    let logout: () -> Void
    let sendMail: (String) -> Void
    let openLink: (URL) -> Void
    let share: (URL) -> Void
}

final class MainSceneDIContainer: NSObject {
    
    func makeStarredSceneDIContainer(dependencies: UserSceneDIContainer.Dependencies) -> UserSceneDIContainer {
        return UserSceneDIContainer(dependencies: dependencies)
    }

    func makeRepSceneDIContainer(dependencies: RepSceneDIContainer.Dependencies) -> RepSceneDIContainer {
        return RepSceneDIContainer(dependencies: dependencies)
    }

    let dependencies: MainSceneCoordinatorDependencies
    
    init(dependencies: MainSceneCoordinatorDependencies) {
        self.dependencies = dependencies
    }

    func makeTabController() -> UITabBarController {
        let controller = UITabBarController()
        controller.delegate = self
        controller.setViewControllers(getControllers(), animated: true)
        controller.selectedIndex = TabBarPage.home.pageOrderNumber()
        controller.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = .systemBackground
        return controller
    }

    private func getControllers() -> [UIViewController] {
        let pages: [TabBarPage] = TabBarPage.allCases
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        return controllers
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageImage(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .home:
            let coordinator = HomeFlowCoordinator(navigationController: navController)
            coordinator.start()

        case .notifications:
            let coordinator = NotificationsFlowCoordinator(navigationController: navController)
            coordinator.start()

        case .explore:
            let coordinator = ExploreFlowCoordinator(navigationController: navController)
            coordinator.start()

        case .profile:
            let profileDependencies = ProfileDIContainer.Dependencies(
                openUserProfile: openUserProfile(_:),
                openRepository: openRepository(_:),
                sendMail: dependencies.sendMail,
                openLink: dependencies.openLink,
                share: dependencies.share
            )
            let container = ProfileDIContainer(dependencies: profileDependencies)
            let coordinator = ProfileFlowCoordinator(in: navController, with: container)
            coordinator.start()
        }
        return navController
    }
    
    func openRepository(_ repository: Repository) {
        fatalError()
    }
    
    func openUserProfile(_ user: User) {
        fatalError()
    }
}

enum TabBarPage: CaseIterable {
    case home
    case notifications
    case explore
    case profile

    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .notifications
        case 2: self = .explore
        case 3: self = .profile
        default: return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .home:
            return NSLocalizedString("Home", comment: "")
        case .notifications:
            return NSLocalizedString("Notifications", comment: "")
        case .explore:
            return NSLocalizedString("Explore", comment: "")
        case .profile:
            return NSLocalizedString("Profile", comment: "")
        }
    }
    
    func pageImage() -> UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .notifications:
            return UIImage(systemName: "bell.fill")
        case .explore:
            return UIImage(systemName: "gyroscope")
        case .profile:
            return UIImage(systemName: "person")
        }
    }

    func pageOrderNumber() -> Int {
        // todo save last selected page
        switch self {
        case .home: return 0
        case .notifications: return 1
        case .explore: return 2
        case .profile: return 3
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension MainSceneDIContainer: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
