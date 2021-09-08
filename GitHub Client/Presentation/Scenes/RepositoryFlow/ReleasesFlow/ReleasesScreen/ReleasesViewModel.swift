//
//  ReleasesViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

struct ReleasesActions {
    let show: (Release) -> Void
}

protocol ReleasesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func refresh()
}

protocol ReleasesViewModelOutput {
    var state: Observable<ItemsSceneState<Release>> { get }
}

typealias ReleasesViewModel = ReleasesViewModelInput & ReleasesViewModelOutput

final class ReleasesViewModelImpl: ReleasesViewModel {

    // MARK: - Output

    var state: Observable<ItemsSceneState<Release>> = Observable(.loading)

    // MARK: - Private variables

    private let url: URL
    private let useCase: ListUseCase
    private let actions: ReleasesActions
    private var lastPage: Int?
    private var currentPage = 1

    // MARK: - Lifecycle

    init(_ url: URL, useCase: ListUseCase, actions: ReleasesActions) {
        self.url = url
        self.useCase = useCase
        self.actions = actions
    }
}

// MARK: - Input
extension ReleasesViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        switch state.value {
        case .loaded(let items, _):
            let release = items[indexPath.row]
            actions.show(release)
        default:
            break
        }
    }

    func refresh() {
        fetch()
    }
}

// MARK: - Private
private extension ReleasesViewModelImpl {
    func fetch() {
        state.value = .loading
        let model = ListRequestModel(path: url, page: currentPage)
        useCase.fetchReleases(model) { result in
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
