//
//  ItemsListFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

protocol ItemsListFactory {
    func makePullRequestsViewController(repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest>
    func makeReleasesViewController(repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewController<Release>
}

final class ItemsListFactoryImpl {

    private let dataTransferService: DataTransferService
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ItemsListFactory
extension ItemsListFactoryImpl: ItemsListFactory {
    func makePullRequestsViewController(repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest> {
        .create(with: createPullRequestsViewModel(repository: repository, actions: actions))
    }

    func makeReleasesViewController(repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewController<Release> {
        .create(with: createReleasesViewModel(repository: repository, actions: actions))
    }
}

private extension ItemsListFactoryImpl {
    func createPullRequestsViewModel(repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewModelImpl<PullRequest> {
        .init(type: .pullRequests(repository), useCase: createItemsListUseCase(), actions: actions)
    }

    func createReleasesViewModel(repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewModelImpl<Release> {
        .init(type: .releases(repository), useCase: createItemsListUseCase(), actions: actions)
    }

    func createItemsListUseCase() -> ItemsListUseCase {
        return ItemsListUseCaseImpl.init(repository: createItemsListRepository())
    }

    func createItemsListRepository() -> ItemsListRepository {
        return ItemsListRepositoryImpl(dataTransferService: dataTransferService)
    }
}
