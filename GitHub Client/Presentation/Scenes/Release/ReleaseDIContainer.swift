//
//  ReleaseDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

final class ReleaseDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
        let release: Release
    }

    // MARK: - Private variables

    private let dependencies: Dependencies
    private let releaseFactory: ReleaseFactory

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
        self.releaseFactory = ReleaseFactoryImpl()
    }
}

// MARK: - ReleaseFlowCoordinatorDependencies
extension ReleaseDIContainer: ReleaseFlowCoordinatorDependencies {
    func releaseViewController(actions: ReleaseActions) -> UIViewController {
        releaseFactory.releaseViewController(dependencies.release, actions: actions)
    }
}
