//
//  IssuesFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol IssuesFactory {
    func makeMyIssuesViewController(actions: IssuesActions) -> IssuesViewController
    func makeIssuesViewController(repository: Repository, actions: IssuesActions) -> IssuesViewController
}

final class IssuesFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - IssueFactory
extension IssuesFactoryImpl: IssuesFactory {
    func makeMyIssuesViewController(actions: IssuesActions) -> IssuesViewController {
        .create(with: createMyIssuesViewModel(actions: actions))
    }

    func makeIssuesViewController(repository: Repository, actions: IssuesActions) -> IssuesViewController {
        .create(with: createIssuesViewModel(repository: repository, actions: actions))
    }
}

private extension IssuesFactoryImpl {
    func createMyIssuesViewModel(actions: IssuesActions) -> IssuesViewModel {
        IssuesViewModelImpl.init(useCase: createIssuesUseCase(), issuesType: .myIssues, actions: actions)
    }

    func createIssuesViewModel(repository: Repository, actions: IssuesActions) -> IssuesViewModel {
        IssuesViewModelImpl.init(useCase: createIssuesUseCase(), issuesType: .issues(repository), actions: actions)
    }

    func createIssuesUseCase() -> IssuesUseCase {
        return IssuesUseCaseImpl(repository: createIssuesRepository())
    }

    func createIssuesRepository() -> IssueRepository {
        return IssueRepositoryImpl(dataTransferService: dataTransferService)
    }
}
