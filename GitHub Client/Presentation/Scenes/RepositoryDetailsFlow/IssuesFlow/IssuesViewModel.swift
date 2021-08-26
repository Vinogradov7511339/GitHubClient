//
//  IssuesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

struct IssuesActions {
    let showIssue: (Issue) -> Void
}

protocol IssuesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func refresh()
}

protocol IssuesViewModelOutput {
    var state: Observable<ItemsSceneState<Issue>> { get }
}

typealias IssuesViewModel = IssuesViewModelInput & IssuesViewModelOutput

final class IssuesViewModelImpl: IssuesViewModel {

    // MARK: - Output
    var state: Observable<ItemsSceneState<Issue>> = Observable(.loading)

    // MARK: - Private
    private let issueUseCase: IssueUseCase
    private let repository: Repository
    private let actions: IssuesActions
    private var lastPage: Int?
    private var currentPage = 1

    init(issueUseCase: IssueUseCase, repository: Repository, actions: IssuesActions) {
        self.issueUseCase = issueUseCase
        self.repository = repository
        self.actions = actions
    }
}

// MARK: - Input
extension IssuesViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch state.value {
        case .loaded(let issues):
            let issue = issues[indexPath.row]
            actions.showIssue(issue)
        default:
            break
        }
    }
}

// MARK: - Private
private extension IssuesViewModelImpl {
    func fetch() {
        state.value = .loading
        issueUseCase.fetchAllIssues(repository, page: currentPage) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.state.value = .loaded(items: model.items)
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
