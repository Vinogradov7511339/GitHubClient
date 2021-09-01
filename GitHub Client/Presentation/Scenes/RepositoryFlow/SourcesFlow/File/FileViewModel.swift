//
//  FilePresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

struct FileActions {
    let openCodeOptions: () -> Void
    let copy: (String) -> Void
    let share: (URL) -> Void
}

protocol FileViewModelInput {
    func viewDidLoad()
    func refresh()

    func copyFilePath()
    func share()
    func openCodeOptions()
}

protocol FileViewModelOutput {
    var state: Observable<DetailsScreenState<File>> { get }
    var settings: CodeOptions { get }
}

typealias FileViewModel = FileViewModelInput & FileViewModelOutput

final class FileViewModelImpl: FileViewModel {

    // MARK: - Output

    var state: Observable<DetailsScreenState<File>> = Observable(.loading)
    var settings: CodeOptions

    // MARK: - Private

    private let filePath: URL
    private let useCase: RepUseCase
    private let actions: FileActions

    init(_ filePath: URL, useCase: RepUseCase, actions: FileActions) {
        self.filePath = filePath
        self.useCase = useCase
        self.actions = actions
        self.settings = SettingsStorageImpl.shared.codeOptions
    }
}

// MARK: - FileViewModelInput
extension FileViewModelImpl {
    func viewDidLoad() {
        fetch()
    }

    func refresh() {
        fetch()
    }

    func copyFilePath() {
        guard case .loaded(let file) = state.value else { return }
        actions.copy(file.path)
    }

    func share() {
        guard case .loaded(let file) = state.value else { return }
        actions.share(file.htmlUrl)
    }

    func openCodeOptions() {
        actions.openCodeOptions()
    }
}

// MARK: - private
private extension FileViewModelImpl {
    func fetch() {
        state.value = .loading
        useCase.fetchFile(path: filePath) { result in
            switch result {
            case .success(let file):
                self.state.value = .loaded(file)
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
}
