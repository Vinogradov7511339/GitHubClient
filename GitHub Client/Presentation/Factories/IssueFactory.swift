//
//  IssueFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol IssueFactory {
    func issueViewController(_ issue: Issue, actions: IssueActions) -> UIViewController
}

final class IssueFactoryImpl {

    private let dataTrasferService: DataTransferService
    private let filterStorage: IssueFilterStorage

    init(dataTrasferService: DataTransferService, filterStorage: IssueFilterStorage) {
        self.dataTrasferService = dataTrasferService
        self.filterStorage = filterStorage
    }
}

// MARK: - IssueFactory
extension IssueFactoryImpl: IssueFactory {
    func issueViewController(_ issue: Issue, actions: IssueActions) -> UIViewController {
        IssueDetailsViewController.create(with: issueViewModel(issue, actions: actions))
    }
}

// MARK: - Private
private extension IssueFactoryImpl {
    func issueViewModel(_ issue: Issue, actions: IssueActions) -> IssueViewModel {
        IssueViewModelImpl(useCase: issueUseCase, actions: actions, issue: issue)
    }

    var issueUseCase: IssueUseCase {
        IssueUseCaseImpl(repRepository: repository, filterStorage: filterStorage)
    }

    var repository: RepRepository {
        RepRepositoryImpl(dataTransferService: dataTrasferService)
    }
}
