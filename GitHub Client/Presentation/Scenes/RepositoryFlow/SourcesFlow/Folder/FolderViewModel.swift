//
//  FolderViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

struct FolderActions {
    var openFolder: (FolderItem) -> Void
    var openFile: (URL) -> Void
    var openFolderSettings: () -> Void
    var share: (URL) -> Void
    var copy: (String) -> Void
}

protocol FolderViewModelInput {
    func viewDidLoad()
    func refresh()
    func didSelectItem(at indexPath: IndexPath)
    func openFolderSettings()
    func share()
    func copyFolderPath()
}

protocol FolderViewModelOutput {
    var title: Observable<String> { get }
    var state: Observable<FolderScreenState> { get }
}

enum FolderScreenState {
    case loading
    case loaded([FolderItem])
    case error(Error)
}

typealias FolderViewModel = FolderViewModelInput & FolderViewModelOutput

final class FolderViewModelImpl {

    // MARK: - INPUT

    var title: Observable<String> = Observable("")
    var state: Observable<FolderScreenState> = Observable(.loading)

    // MARK: - Private

    private let folder: FolderItem
    private let useCase: RepUseCase
    private let actions: FolderActions

    init(_ folder: FolderItem, useCase: RepUseCase, actions: FolderActions) {
        self.folder = folder
        self.useCase = useCase
        self.actions = actions
        self.title.value = folder.name
    }
}

// MARK: - FolderViewModel
extension FolderViewModelImpl: FolderViewModel {
    func viewDidLoad() {
        state.value = .loading
        fetch()
    }

    func refresh() {
        state.value = .loading
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard case .loaded(let items) = state.value else { return }
        let item = items[indexPath.row]
        switch item.type {
        case .folder:
            actions.openFolder(item)
        case .file:
            actions.openFile(item.url)
        }
    }

    func openFolderSettings() {
        actions.openFolderSettings()
    }

    func share() {
        // html url
//        actions.share(folder.url)
    }

    func copyFolderPath() {}
}

// MARK: - private
private extension FolderViewModelImpl {
    func fetch() {
        useCase.fetchContent(path: folder.url) { result in
            switch result {
            case .success(let items):
                self.state.value = .loaded(items)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
}
