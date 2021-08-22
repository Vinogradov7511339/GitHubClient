//
//  ExploreFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreFactory {
    func exploreViewController() -> UIViewController
}

final class ExploreFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ExploreFactory
extension ExploreFactoryImpl: ExploreFactory {
    func exploreViewController() -> UIViewController {
        ExploreTempViewController.create(with: exploreViewModel())
    }
}

// MARK: - Private
private extension ExploreFactoryImpl {
    func exploreViewModel() -> ExploreTempViewModel {
        ExploreTempViewModelImpl(useCase: exploreUseCase)
    }

    var exploreUseCase: ExploreTempUseCase {
        ExploreTempUseCaseImpl(exploreRepository: exploreRepository)
    }

    var exploreRepository: ExploreTempRepository {
        ExploreTempRepositoryImpl(dataTransferService: dataTransferService)
    }
}
