//
//  DiffViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 28.08.2021.
//

import UIKit

struct TempDiff {}

struct DiffActions {}

protocol DiffViewModelInput {
    func viewDidLoad()
    func refresh()
}

protocol DiffViewModelOutput {
    var state: Observable<ItemsSceneState<TempDiff>> { get }
}

typealias DiffViewModel = DiffViewModelInput & DiffViewModelOutput

final class DiffViewModelImpl: DiffViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<TempDiff>> = Observable(.loading)

    // MARK: - Private variables

    private let diffUrl: URL
    private let useCase: PRUseCase
    private let actions: DiffActions

    // MARK: - Lifecycle

    init(diffUrl: URL, useCase: PRUseCase, actions: DiffActions) {
        self.diffUrl = diffUrl
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension DiffViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }
}

// MARK: - Private
private extension DiffViewModelImpl {
    func fetch() {
        state.value = .loading
        useCase.fetchDiff(diffUrl) { result in
            switch result {
            case .success(let raw):
                self.handleDiff(raw)
            case .failure(let error):
                self.state.value = .error(error: error)
            }
        }
    }

    func handleDiff(_ raw: String) {
        print("a")
    }
}
