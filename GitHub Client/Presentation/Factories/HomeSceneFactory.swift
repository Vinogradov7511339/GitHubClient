//
//  HomeSceneFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import UIKit

protocol HomeSceneFactory {
    func homeViewController(_ actions: HomeActions) -> UIViewController
    func myIssuesViewController(_ actions: MyIssuesActions) -> UIViewController
}

final class HomeSceneFactoryImpl {
    private let dataTransferService: DataTransferService
    private let profileStorage: ProfileLocalStorage
    private let issueFilerStorage: IssueFilterStorage

    init(dataTransferService: DataTransferService,
         profileStorage: ProfileLocalStorage,
         issueFilerStorage: IssueFilterStorage) {
        self.dataTransferService = dataTransferService
        self.profileStorage = profileStorage
        self.issueFilerStorage = issueFilerStorage
    }
}

// MAK: - HomeSceneFactory
extension HomeSceneFactoryImpl: HomeSceneFactory {
    func homeViewController(_ actions: HomeActions) -> UIViewController {
        HomeViewController.create(with: createHomeViewModel(actions: actions))
    }

    func myIssuesViewController(_ actions: MyIssuesActions) -> UIViewController {
        MyIssuesViewController.create(with: myIssuesViewModel(actions))
    }
}

private extension HomeSceneFactoryImpl {
    func createHomeViewModel(actions: HomeActions) -> HomeViewModel {
        HomeViewModelImpl(useCase: homeUseCase, actions: actions)
    }

    func myIssuesViewModel(_ actions: MyIssuesActions) -> MyIssuesViewModel {
        MyIssuesViewModelImpl(useCase: homeUseCase, actions: actions)
    }
    
    var homeUseCase: HomeUseCase {
        HomeUseCaseImpl(repository: profileRepository, issuesFilterStorage: issueFilerStorage)
    }

    var profileRepository: MyProfileRepository {
        MyProfileRepositoryImpl(dataTransferService: dataTransferService, localStorage: profileStorage)
    }
}
