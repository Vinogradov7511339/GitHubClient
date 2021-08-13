//
//  ItemsListFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

protocol ItemsListFactory {
    func createMyPullRequestsViewController(actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest>

    func makeStargazersViewController(repository: Repository, actions: ItemsListActions<User>) -> ItemsListViewController<User>
    func makeForksViewController(repository: Repository, actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository>
    func makePullRequestsViewController(repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest>
    func makeReleasesViewController(repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewController<Release>
    func makeCommitsViewController(repository: Repository, actions: ItemsListActions<Commit>) -> ItemsListViewController<Commit>
}

final class ItemsListFactoryImpl {

    private let dataTransferService: DataTransferService
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - ItemsListFactory
extension ItemsListFactoryImpl: ItemsListFactory {
    func createMyPullRequestsViewController(actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest> {
        .create(with: createMyPullRequestsViewModel(actions: actions))
    }

    func makeStargazersViewController(repository: Repository, actions: ItemsListActions<User>) -> ItemsListViewController<User> {
        .create(with: createStargazersViewModel(repository: repository, actions: actions))
    }

    func makeForksViewController(repository: Repository, actions: ItemsListActions<Repository>) -> ItemsListViewController<Repository> {
        .create(with: createForksViewModel(repository: repository, actions: actions))
    }

    func makePullRequestsViewController(repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewController<PullRequest> {
        .create(with: createPullRequestsViewModel(repository: repository, actions: actions))
    }

    func makeReleasesViewController(repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewController<Release> {
        .create(with: createReleasesViewModel(repository: repository, actions: actions))
    }

    func makeCommitsViewController(repository: Repository, actions: ItemsListActions<Commit>) -> ItemsListViewController<Commit> {
        .create(with: createCommitsViewModel(repository: repository, actions: actions))
    }
}

private extension ItemsListFactoryImpl {

    func createMyPullRequestsViewModel(actions: ItemsListActions<PullRequest>) -> ItemsListViewModelImpl<PullRequest> {
        .init(type: .myPullRequests, useCase: createItemsListUseCase(), actions: actions)
    }

    func createStargazersViewModel(repository: Repository, actions: ItemsListActions<User>) -> ItemsListViewModelImpl<User> {
        .init(type: .stargazers(repository), useCase: createItemsListUseCase(), actions: actions)
    }

    func createForksViewModel(repository: Repository, actions: ItemsListActions<Repository>) -> ItemsListViewModelImpl<Repository> {
        .init(type: .forks(repository), useCase: createItemsListUseCase(), actions: actions)
    }

    func createPullRequestsViewModel(repository: Repository, actions: ItemsListActions<PullRequest>) -> ItemsListViewModelImpl<PullRequest> {
        .init(type: .pullRequests(repository), useCase: createItemsListUseCase(), actions: actions)
    }

    func createReleasesViewModel(repository: Repository, actions: ItemsListActions<Release>) -> ItemsListViewModelImpl<Release> {
        .init(type: .releases(repository), useCase: createItemsListUseCase(), actions: actions)
    }

    func createCommitsViewModel(repository: Repository, actions: ItemsListActions<Commit>) -> ItemsListViewModelImpl<Commit> {
        .init(type: .commits(repository), useCase: createItemsListUseCase(), actions: actions)
    }

    func createItemsListUseCase() -> ItemsListUseCase {
        return ItemsListUseCaseImpl.init(repository: createItemsListRepository())
    }

    func createItemsListRepository() -> ItemsListRepository {
        return ItemsListRepositoryImpl(dataTransferService: dataTransferService)
    }
}
