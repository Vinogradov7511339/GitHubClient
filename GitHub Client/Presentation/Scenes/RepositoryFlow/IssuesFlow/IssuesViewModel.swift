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

    // MARK: - Private variables

    private let url: URL
    private let issueUseCase: IssueUseCase
    private let actions: IssuesActions
    private var currentPage = 1
    private var lastPage = 1

    init(_ url: URL, issueUseCase: IssueUseCase, actions: IssuesActions) {
        self.url = url
        self.issueUseCase = issueUseCase
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
        case .loaded(let issues, _):
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
        issueUseCase.fetchAllIssues(url, page: currentPage) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.state.value = .loaded(items: model.items, indexPaths: [])
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
