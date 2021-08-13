//
//  CommitsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import UIKit

struct CommitsActions {
    let showCommit: (Commit) -> Void
}

protocol CommitsViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol CommitsViewModelOutput {
    var commits: Observable<[Commit]> { get }
}

typealias CommitsViewModel = CommitsViewModelInput & CommitsViewModelOutput

final class CommitsViewModelImpl: CommitsViewModel {

    // MARK: - Output
    var commits: Observable<[Commit]> = Observable([])

    // MARK: - Private
    private let useCase: CommitsUseCase
    private let repository: Repository
    private let actions: CommitsActions
    private var lastPage: Int?

    init(useCase: CommitsUseCase, repository: Repository, actions: CommitsActions) {
        self.useCase = useCase
        self.repository = repository
        self.actions = actions
    }
}

// MARK: - Input
extension CommitsViewModelImpl {
    func viewDidLoad() {
        let page = 1
        let request = CommitsRequestModel(page: page, repository: repository)
        useCase.fetch(request: request) { result in
            switch result {
            case .success(let model):
                self.lastPage = model.lastPage
                self.commits.value.append(contentsOf: model.items)
            case .failure(let error):
                print(error)
            }
        }
    }

    func didSelectItem(at indexPath: IndexPath) {
        actions.showCommit(commits.value[indexPath.row])
    }
}


