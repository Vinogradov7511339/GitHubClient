//
//  ExploreDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

final class ExploreDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let exploreFactory: ExploreFactory

    // MARK: - Lifecycle

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        exploreFactory = ExploreFactoryImpl(dataTransferService: dependencies.dataTransferService)
    }
}

// MARK: - ExploreFlowCoordinatorDependencies
extension ExploreDIContainer: ExploreFlowCoordinatorDependencies {
    func exploreViewController() -> UIViewController {
        exploreFactory.exploreViewController()
    }
}
