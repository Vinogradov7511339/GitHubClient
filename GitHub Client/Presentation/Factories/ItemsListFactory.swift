//
//  ItemsListFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

protocol ItemsListFactory {
    func makeMyFollowersViewController(actions: ItemsListActions<User>) -> ItemsListViewController<User>
    func makeMyFollowingViewController(actions: ItemsListActions<User>) -> ItemsListViewController<User>

    func createMyRepositoriesViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository>
    func createMyStarredViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository>

    func createMyIssuesViewController(actions: ItemsListActions<Issue>) -> ItemsListViewController<Issue>
    func createMyPullRequestsViewController(actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest>
}

final class ItemsListFactoryImpl {

    private let dataTransferService: DataTransferService
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ItemsListFactory
extension ItemsListFactoryImpl: ItemsListFactory {
    func makeMyFollowersViewController(actions: ItemsListActions<User>) -> ItemsListViewController<User> {
        .create(with: createFollowersViewModel(actions: actions))
    }

    func makeMyFollowingViewController(actions: ItemsListActions<User>) -> ItemsListViewController<User> {
        .create(with: createFollowingViewModel(actions: actions))
    }

    func createMyRepositoriesViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        .create(with: createRepositoriesViewModel(actions: actions))
    }

    func createMyStarredViewController(actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        .create(with: createStarredViewModel(actions: actions))
    }

    func createMyIssuesViewController(actions: ItemsListActions<Issue>) -> ItemsListViewController<Issue> {
        .create(with: createIssuesViewModel(actions: actions))
    }

    func createMyPullRequestsViewController(actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest> {
        .create(with: createPullRequestsViewModel(actions: actions))
    }
}

private extension ItemsListFactoryImpl {
    func createFollowingViewModel(actions: ItemsListActions<User>) -> ItemsListViewModelImpl<User> {
        .init(type: .myFollowing, useCase: createItemsListUseCase(), actions: actions)
    }

    func createRepositoriesViewModel(actions: ItemsListActions<Repository>) -> ItemsListViewModelImpl<Repository> {
        .init(type: .myRepositories, useCase: createItemsListUseCase(), actions: actions)
    }

    func createFollowersViewModel(actions: ItemsListActions<User>) -> ItemsListViewModelImpl<User> {
        .init(type: .myFollowers, useCase: createItemsListUseCase(), actions: actions)
    }

    func createStarredViewModel(actions: ItemsListActions<Repository>) -> ItemsListViewModelImpl<Repository> {
        .init(type: .myStarredRepositories, useCase: createItemsListUseCase(), actions: actions)
    }

    func createIssuesViewModel(actions: ItemsListActions<Issue>) -> ItemsListViewModelImpl<Issue> {
        .init(type: .myIssues, useCase: createItemsListUseCase(), actions: actions)
    }

    func createPullRequestsViewModel(actions: ItemsListActions<PullRequest>) -> ItemsListViewModelImpl<PullRequest> {
        .init(type: .myPullRequests, useCase: createItemsListUseCase(), actions: actions)
    }

    func createItemsListUseCase() -> ItemsListUseCase {
        return ItemsListUseCaseImpl.init(repository: createItemsListRepository())
    }

    func createItemsListRepository() -> ItemsListRepository {
        return ItemsListRepositoryImpl(dataTransferService: dataTransferService)
    }
}
