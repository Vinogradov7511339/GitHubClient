//
//  TabCoordinator.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

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
        switch self {
        case .home: return 0
        case .notifications: return 1
        case .explore: return 2
        case .profile: return 3
        }
    }

    // Add tab icon value

    // Add tab icon selected / deselected color

    // etc
}

class TabCoordinator: NSObject {

    var tabBarController: UITabBarController
    private let window: UIWindow

    init(in window: UIWindow) {
        self.window = window
        self.tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPage] = TabBarPage.allCases
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }

    deinit {
        //todo check logout
        print("TabCoordinator deinit")
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber() //todo save last opened tab?
        tabBarController.tabBar.isTranslucent = false
//        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground

        if let previousController = window.rootViewController {
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
                self.window.subviews.forEach { $0.removeFromSuperview() }
                self.window.rootViewController = self.tabBarController
            } completion: { _ in
                previousController.dismiss(animated: false, completion: {
                    previousController.view.removeFromSuperview()
                })
            }
        } else {
            window.rootViewController = self.tabBarController
        }
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
            let coordinator = ProfileFlowCoordinator(navigationController: navController)
            coordinator.start()
        }
        return navController
    }

    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }

        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
