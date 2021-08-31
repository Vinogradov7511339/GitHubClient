//
//  BranchesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.08.2021.
//

import UIKit

struct BranchesActions {
    let select: (Branch) -> Void
}

protocol BranchesViewModelInput {
    func viewDidLoad()
    func reload()
    func didSelectRow(at indexPath: IndexPath)
}

protocol BranchesViewModelOutput {
    var state: Observable<ItemsSceneState<Branch>> { get }
}

typealias BranchesViewModel = BranchesViewModelInput & BranchesViewModelOutput

final class BranchesViewModelImpl: BranchesViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<Branch>> = Observable(.loading)

    // MARK: - Private variables

    private let url: URL
    private let useCase: ListUseCase
    private let actions: BranchesActions
    private var currentPage = 1
    private var lastPage: Int?

    // MARK: - Lifcycle

    init(_ url: URL, useCase: ListUseCase, actions: BranchesActions) {
        self.url = url
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension BranchesViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func reload() {
        fetch()
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard case .loaded(let items) = state.value else { return }
        let selectedBranch = items[indexPath.row]
        actions.select(selectedBranch)
    }
}

// MARK: - Private
private extension BranchesViewModelImpl {
    func fetch() {
        let model = ListRequestModel(path: url, page: currentPage)
        useCase.fetchBranches(model) { result in
            switch result {
            case .success(let response):
                self.lastPage = response.lastPage
                self.state.value = .loaded(items: response.items)
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }
}
