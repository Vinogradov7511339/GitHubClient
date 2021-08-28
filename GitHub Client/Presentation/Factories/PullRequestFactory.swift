//
//  PullRequestFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol PullRequestFactory {
    func pullRequestViewController(_ pullRequest: PullRequest, actions: PRActions) -> UIViewController
    func diffViewController(_ url: URL, actions: DiffActions) -> UIViewController
}

final class PullRequestFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - PullRequestFactory
extension PullRequestFactoryImpl: PullRequestFactory {
    func pullRequestViewController(_ pullRequest: PullRequest, actions: PRActions) -> UIViewController {
        PRViewController.create(with: prViewModel(pullRequest, actions: actions))
    }

    func diffViewController(_ url: URL, actions: DiffActions) -> UIViewController {
        DiffViewController.create(with: diffViewModel(url, actions: actions))
    }
}

// MARK: - Private
private extension PullRequestFactoryImpl {
    func prViewModel(_ pullRequest: PullRequest, actions: PRActions) -> PRViewModel {
        PRViewModelImpl(useCase: prUseCase, pullRequest: pullRequest, actions: actions)
    }

    func diffViewModel(_ url: URL, actions: DiffActions) -> DiffViewModel {
        DiffViewModelImpl(diffUrl: url, useCase: prUseCase, actions: actions)
    }

    var prUseCase: PRUseCase {
        PRUseCaseImpl(repRepository: repository)
    }

    var repository: RepRepository {
        RepRepositoryImpl(dataTransferService: dataTransferService)
    }
}
