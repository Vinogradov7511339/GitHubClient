//
//  TabBarViewController.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
//        tabBar.tintColor = .label
        setupControllers()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image

        return navController
    }
    
    private func setupControllers() {
        let homeViewController = createNavController(for: HomeConfigurator.createHomeModule(), title: "Work", image: UIImage(systemName: "house"))
        let notificationsViewController = createNavController(for: NotificationsConfigurator.createModule(), title: "Notifications", image: UIImage(systemName: "bell.fill"))
        let exploreViewController = createNavController(for: ExploreConfigurator.createModule(), title: "Explore", image: UIImage(systemName: "gyroscope"))
        
        let profileViewController = createNavController(for: ProfileConfigurator.createProfileModule(with: .myProfile), title: "Profile", image: UIImage(systemName: "person"))
        
        viewControllers = [homeViewController, notificationsViewController, exploreViewController, profileViewController]
    }
}
