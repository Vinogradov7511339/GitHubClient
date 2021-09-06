//
//  MainSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit

final class MainSceneDIContainer: NSObject {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let profileStorage: ProfileLocalStorage
        let searchFilterStorage: SearchFilterStorage
        let exploreSettingsStorage: ExploreWidgetsRequestStorage
        let issueFilterStorage: IssueFilterStorage

        let logout: () -> Void
        let openSettings: (UINavigationController) -> Void
        let openRepository: (URL, UINavigationController) -> Void
        let openUser: (URL, UINavigationController) -> Void
        let openIssue: (Issue, UINavigationController) -> Void
        let openPullRequest: (PullRequest, UINavigationController) -> Void

        let sendMail: (String) -> Void
        let openLink: (URL) -> Void
        let share: (URL) -> Void
    }

    // MARK: - Private variables

    private let dependencies: Dependencies

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
    }

}

// MARK: - MainCoordinatorDependencies
extension MainSceneDIContainer: MainCoordinatorDependencies {
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
        case .home:
            let container = HomeDIContainer(homeDependencies())
            let coordinator = HomeFlowCoordinator(with: container, in: navigation)
            coordinator.start()

        case .explore:
            let container = ExploreDIContainer(exploreDependencies())
            let explore = ExploreFlowCoordinator(with: container, in: navigation)
            explore.start()

        case .notifications:
            let container = NotificationsDIContainer(notificationsDependencies())
            let coordinator = NotificationsFlowCoordinator(with: container, in: navigation)
            coordinator.start()

        case .profile:
            let container = ProfileDIContainer(profileDependencies())
            let coordinator = ProfileFlowCoordinator(with: container, in: navigation)
            coordinator.start()
        }
        return navigation
    }
}

// MARK: - Containers
private extension MainSceneDIContainer {
    func homeDependencies() -> HomeDIContainer.Dependencies {
        .init(dataTransferService: dependencies.dataTransferService,
              profileStorage: dependencies.profileStorage,
              issueFilterStorage: dependencies.issueFilterStorage,
              showIssue: dependencies.openIssue)
    }

    func exploreDependencies() -> ExploreDIContainer.Dependencies {
        .init(dataTransferService: dependencies.dataTransferService,
              searchFilterStorage: dependencies.searchFilterStorage,
              exploreSettingsStorage: dependencies.exploreSettingsStorage,
              showRepository: dependencies.openRepository,
              showIssue: dependencies.openIssue,
              showPullRequest: dependencies.openPullRequest,
              showUser: dependencies.openUser)
    }

    func notificationsDependencies() -> NotificationsDIContainer.Dependencies {
        .init(apiDataTransferService: dependencies.dataTransferService)
    }

    func profileDependencies() -> ProfileDIContainer.Dependencies {
        .init(dataTransferService: dependencies.dataTransferService,
              openUserProfile: dependencies.openUser,
              openRepository: dependencies.openRepository,
              openSettings: dependencies.openSettings,
              sendMail: dependencies.sendMail,
              openLink: dependencies.openLink,
              share: dependencies.share)
    }
}

// MARK: - Tabbar
private extension MainSceneDIContainer {
    enum TabBarPage: Int, CaseIterable {
        case home
        case explore
        case notifications
        case profile

        var title: String {
            switch self {
            case .home:
                return NSLocalizedString("Home", comment: "")
            case .explore:
                return NSLocalizedString("Explore", comment: "")
            case .notifications:
                return NSLocalizedString("Notifications", comment: "")
            case .profile:
                return NSLocalizedString("Profile", comment: "")
            }
        }

        var image: UIImage? {
            switch self {
            case .home:
                return UIImage.TabBar.home
            case .explore:
                return UIImage.TabBar.explore
            case .notifications:
                return UIImage.TabBar.notifications
            case .profile:
                return UIImage.TabBar.profile
            }
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
