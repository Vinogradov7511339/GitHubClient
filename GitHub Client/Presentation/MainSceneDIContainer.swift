//
//  MainSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

final class MainSceneDIContainer: NSObject {

    struct Dependencies {
        let logout: () -> Void
        let sendMail: (String) -> Void
        let openLink: (URL) -> Void
        let share: (URL) -> Void
    }

    func makeStarredSceneDIContainer(
        dependencies: UserSceneDIContainer.Dependencies) -> UserSceneDIContainer {
        return UserSceneDIContainer(parentContainer: self, dependencies: dependencies)
    }

    func makeRepSceneDIContainer(
        dependencies: RepSceneDIContainer.Dependencies) -> RepSceneDIContainer {
        return RepSceneDIContainer(parentContainer: self, dependencies: dependencies)
    }

    var apiDataTransferService: DataTransferService {
        parentContainer.apiDataTransferService
    }

    var favoritesStorage: FavoritesStorage {
        parentContainer.favoritesStorage
    }

    var profileStorage: ProfileLocalStorage {
        parentContainer.profileStorage
    }

    private let parentContainer: AppDIContainer
    let dependencies: Dependencies

    init(appDIContainer: AppDIContainer, dependencies: Dependencies) {
        self.parentContainer = appDIContainer
        self.dependencies = dependencies
    }

    func makeTabController() -> UITabBarController {
        let controller = UITabBarController()
        controller.delegate = self
        controller.tabBar.isTranslucent = false
        return controller
    }

    func configureTabController(controller: UITabBarController, homeDependencies: HomeDIContainer.Actions,
                                profileDependencies: ProfileDIContainer.Actions) {
        let controllers = getControllers(homeDependencies: homeDependencies,
                                         profileDependencies: profileDependencies)
        controller.setViewControllers(controllers, animated: true)
        controller.selectedIndex = TabBarPage.home.pageOrderNumber()
    }

    private func getControllers(homeDependencies: HomeDIContainer.Actions,
                                profileDependencies: ProfileDIContainer.Actions) -> [UIViewController] {
        let pages: [TabBarPage] = TabBarPage.allCases
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UINavigationController] = pages
            .map({ getTabController($0, homeDependencies: homeDependencies,
                                    profileDependencies: profileDependencies) })
        return controllers
    }

    private func getTabController(_ page: TabBarPage, homeDependencies: HomeDIContainer.Actions,
                                  profileDependencies: ProfileDIContainer.Actions) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageImage(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .home:
            let container = makeHomeContainer(homeActions: homeDependencies)
            let coordinator = HomeFlowCoordinator(container: container, navigationController: navController)
            coordinator.start()

        case .events:
            let dependencies = EventsSceneDIContainer.Dependencies(
                apiDataTransferService: parentContainer.apiDataTransferService)
            let container = EventsSceneDIContainer(dependencies: dependencies)
            let coordinator = EventsFlowCoordinator(navigationController: navController, container: container)
            coordinator.start()

        case .explore:
            let dependencies = NotificationsDIContainer.Dependencies(
                apiDataTransferService: parentContainer.apiDataTransferService)
            let container = NotificationsDIContainer(dependencies: dependencies)
            let coordinator = NotificationsFlowCoordinator(container: container,
                                                           navigationController: navController)
            coordinator.start()

        case .profile:
            let container = makeProfileContainer(profileActions: profileDependencies)
            let coordinator = ProfileFlowCoordinator(in: navController, with: container)
            coordinator.start()
        }
        return navController
    }

    private func makeHomeContainer(homeActions: HomeDIContainer.Actions) -> HomeDIContainer {
        return HomeDIContainer(parentContainer: self, actions: homeActions)
    }

    private func makeProfileContainer(profileActions: ProfileDIContainer.Actions) -> ProfileDIContainer {
        return ProfileDIContainer(parentContainer: self, actions: profileActions)
    }
}

enum TabBarPage: CaseIterable {
    case home
    case events
    case explore
    case profile

    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .events
        case 2: self = .explore
        case 3: self = .profile
        default: return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .home:
            return NSLocalizedString("Home", comment: "")
        case .events:
            return NSLocalizedString("Explore", comment: "")
        case .explore:
            return NSLocalizedString("Notifications", comment: "")
        case .profile:
            return NSLocalizedString("Profile", comment: "")
        }
    }

    func pageImage() -> UIImage? {
        switch self {
        case .home:
            return .home
        case .events:
            return .explore
        case .explore:
            return .notifications
        case .profile:
            return .profile
        }
    }

    func pageOrderNumber() -> Int {
        // todo save last selected page
        switch self {
        case .home: return 0
        case .events: return 1
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
