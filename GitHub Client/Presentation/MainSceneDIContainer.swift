//
//  MainSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

struct MainSceneCoordinatorDependencies {
    let apiDataTransferService: DataTransferService

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

    var openRepository: ((Repository) -> Void)?
    var openUserProfile: ((User) -> Void)?
    var openIssue: ((Issue) -> Void)?

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
//        UITabBar.appearance().barTintColor = .systemBackground
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
            let homeDependencies = HomeDIContainer.Dependencies(
                apiDataTransferService: dependencies.apiDataTransferService,
                showOrganizations: showOrganizations,
                showRepositories: showRepositories,
                showRepository: openRepository,
                showEvent: openIssue
            )
            let container = HomeDIContainer(dependencies: homeDependencies)
            let coordinator = HomeFlowCoordinator(container: container, navigationController: navController)
            coordinator.start()

        case .events:
            let dependencies = EventsSceneDIContainer.Dependencies(
                apiDataTransferService: dependencies.apiDataTransferService)
            let container = EventsSceneDIContainer(dependencies: dependencies)
            let coordinator = EventsFlowCoordinator(navigationController: navController, container: container)
            coordinator.start()

        case .explore:
            let coordinator = ExploreFlowCoordinator(navigationController: navController)
            coordinator.start()

        case .profile:
            let profileDependencies = ProfileDIContainer.Dependencies(
                apiDataTransferService: dependencies.apiDataTransferService,
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
        openRepository?(repository)
    }

    func openUserProfile(_ user: User) {
        openUserProfile?(user)
    }

    func openIssue(_ issue: Issue) {
        openIssue?(issue)
    }

    func showOrganizations() {
        fatalError()
    }

    func showRepositories() {
        fatalError()
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
            return NSLocalizedString("Events", comment: "")
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
        case .events:
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
