//
//  HomeDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import UIKit

final class HomeDIContainer {
    struct Dependencies {
        var showOrganizations: () -> Void
        var showRepositories: () -> Void
        var showRepository: (Repository) -> Void
        var showEvent: (Issue) -> Void
    }

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func createHomeViewController(actions: HomeActions) -> HomeViewController {
        .create(with: createHomeViewModel(actions: actions))
    }

    func createHomeViewModel(actions: HomeActions) -> HomeViewModel {
        return HomeViewModelImpl(useCase: createHomeUseCase(), actions: actions)
    }

    func createHomeUseCase() -> HomeUseCase {
        return HomeUseCaseImpl(repository: createHomeRepository())
    }

    func createHomeRepository() -> HomeRepository {
        return HomeRepositoryImpl()
    }
}
