//
//  IssueFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

protocol IssueFactory {
    func makeIssueViewController(issue: Issue, actions: IssueActions) -> IssueDetailsViewController
}

final class IssueFactoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: IssueFactory
extension IssueFactoryImpl: IssueFactory {
    func makeIssueViewController(issue: Issue, actions: IssueActions) -> IssueDetailsViewController {
        .create(with: createIssueViewModel(issue: issue, actions: actions))
    }
}

// MARK: - Private
private extension IssueFactoryImpl {
    func createIssueViewModel(issue: Issue, actions: IssueActions) -> IssueViewModel {
        IssueViewModelImpl(useCase: createIssueUseCase(),
                           actions: actions,
                           issue: issue)
    }

    func createIssueUseCase() -> IssueUseCase {
        IssueUseCaseImpl(repository: createIssueRepository())
    }

    func createIssueRepository() -> IssueRepository {
        IssueRepositoryImpl(dataTransferService: dataTransferService)
    }
}
