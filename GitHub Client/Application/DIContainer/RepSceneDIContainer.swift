//
//  RepSceneDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import UIKit

class RepSceneDIContainer {

    struct Dependencies {
        let repository: Repository
        var startUserFlow: (User) -> Void
        var openLink: (URL) -> Void
        var share: (URL) -> Void
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeRepFlowCoordinator(in navigationController: UINavigationController) -> RepFlowCoordinator {
        return .init(navigationController: navigationController, dependencies: self)
    }
}

extension RepSceneDIContainer: RepFlowCoordinatorDependencies {
    func startUserFlow(with user: User) {
        dependencies.startUserFlow(user)
    }

    func openLink(url: URL) {
        dependencies.openLink(url)
    }

    func share(url: URL) {
        dependencies.share(url)
    }

    // MARK: - Rep flow

    func makeRepViewController(actions: RepActions) -> RepViewController {
        return RepViewController.create(with: makeRepViewModel(actions: actions))
    }

    func makeRepViewModel(actions: RepActions) -> RepViewModel {
        return RepViewModelImpl(repository: dependencies.repository, repUseCase: makeRepUseCase(), actions: actions)
    }

    func makeRepUseCase() -> RepUseCase {
        return RepUseCaseImpl()
    }

    func makeRepRepository() -> RepRepository {
        return RepRepositoryImpl()
    }
}
