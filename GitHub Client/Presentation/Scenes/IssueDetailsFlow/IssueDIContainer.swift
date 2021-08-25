//
//  IssueDIContainer.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

import UIKit

final class IssueDIContainer {

    // MARK: - Dependencies

    struct Dependencies {
        let dataTransferService: DataTransferService
    }

    // MARK: - Private variables

    private let dependencies: Dependencies

    init(_ dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - IssueCoordinatorDependencies
extension IssueDIContainer: IssueCoordinatorDependencies {}
