//
//  FolderViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

struct FolderActions {
    var openFolder: (URL) -> Void
    var openFile: (URL) -> Void
}

protocol FolderViewModelInput {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol FolderViewModelOutput {
    var title: Observable<String> { get }
    var items: Observable<[FolderItem]> { get }
}

typealias FolderViewModel = FolderViewModelInput & FolderViewModelOutput

final class FolderViewModelImpl {

    // MARK: - INPUT

    var title: Observable<String> = Observable("")
    var items: Observable<[FolderItem]> = Observable([])

    // MARK: - Private

    private let actions: FolderActions
    private let path: URL
    private let useCase: RepUseCase

    init(actions: FolderActions, path: URL, useCase: RepUseCase) {
        self.actions = actions
        self.path = path
        self.useCase = useCase
    }
}

// MARK: - FolderViewModel
extension FolderViewModelImpl: FolderViewModel {
    func viewDidLoad() {
        fetch()
    }

    func didSelectItem(at indexPath: IndexPath) {
        let item = items.value[indexPath.row]
        switch item.type {
        case .folder:
            actions.openFolder(item.url)
        case .file:
            actions.openFile(item.url)
        }
    }
}

// MARK: - private
private extension FolderViewModelImpl {
    func fetch() {
        useCase.fetchContents(path: path) { result in
            switch result {
            case .success(let items):
                self.items.value = items
            case .failure(let error):
                self.handle(error)
            }
        }
    }

    func handle(_ error: Error) {}
}
