//
//  ExtendedRepositoryFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import UIKit

protocol ExtendedRepositoryFactory {
    func makeExtendedRepositoryViewController(actions: RepActions) -> UIViewController
    func makeContentViewCntroller(actions: FolderActions, path: URL) -> UIViewController
    func makeFileVIewController(actions: FileActions, path: URL) -> UIViewController
    func makeBranchesViewController(actions: BranchesActions, repository: Repository) -> UIViewController
}

final class ExtendedRepositoryFactoryImpl {

    private let repository: Repository
    private let favoriteStorage: FavoritesStorage
    private let dataTransferService: DataTransferService

    init(repository: Repository, favoriteStorage: FavoritesStorage, dataTransferService: DataTransferService) {
        self.repository = repository
        self.favoriteStorage = favoriteStorage
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ExtendedRepositoryFactory
extension ExtendedRepositoryFactoryImpl: ExtendedRepositoryFactory {
    func makeExtendedRepositoryViewController(actions: RepActions) -> UIViewController {
        RepViewController.create(with: makeRepViewModel(actions: actions))
    }

    func makeContentViewCntroller(actions: FolderActions, path: URL) -> UIViewController {
        FolderViewController.create(with: makeContextViewModel(actions: actions, path: path))
    }

    func makeFileVIewController(actions: FileActions, path: URL) -> UIViewController {
        FileViewController.create(with: makeFileViewModel(actions: actions, path: path))
    }

    func makeBranchesViewController(actions: BranchesActions, repository: Repository) -> UIViewController {
        BranchesViewController.create(with: makeBranchesViewModel(actions: actions, repository: repository))
    }
}

// MARK: - Private
private extension ExtendedRepositoryFactoryImpl {
    func makeRepViewModel(actions: RepActions) -> RepViewModel {
        return RepViewModelImpl(repository: repository, repUseCase: makeRepUseCase(), actions: actions)
    }

    func makeContextViewModel(actions: FolderActions, path: URL) -> FolderViewModel {
        FolderViewModelImpl(actions: actions, path: path, useCase: makeRepUseCase())
    }

    func makeFileViewModel(actions: FileActions, path: URL) -> FileViewModel {
        FileViewModelImpl(actions: actions, filePath: path, useCase: makeRepUseCase())
    }

    func makeBranchesViewModel(actions: BranchesActions, repository: Repository) -> BranchesViewModel {
        BranchesViewModelImpl(actions: actions, repUserCase: makeRepUseCase(), repository: repository)
    }

    func makeRepUseCase() -> RepUseCase {
        return RepUseCaseImpl(favoritesStorage: favoriteStorage,
                              repositoryStorage: makeRepRepository(),
                              repositoryFacade: makeRepositoryFacade())
    }

    func makeRepRepository() -> RepRepository {
        return RepRepositoryImpl(dataTransferService: dataTransferService)
    }

    func makeRepositoryFacade() -> RepositoryFacade {
        RepositoryFacadeImpl(repRepository: makeRepRepository())
    }
}
