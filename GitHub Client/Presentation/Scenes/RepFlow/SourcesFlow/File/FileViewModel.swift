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
    func copyFilePath()
    func share()
    func openCodeOptions()
}

protocol FileViewModelOutput {
    var file: Observable<File?> { get }
    var settings: CodeOptions { get }
}

typealias FileViewModel = FileViewModelInput & FileViewModelOutput

final class FileViewModelImpl: FileViewModel {

    // MARK: - Output

    var file: Observable<File?> = Observable(nil)
    var settings: CodeOptions

    // MARK: - Private

    private let actions: FileActions
    private let filePath: URL
    private let useCase: RepUseCase

    init(actions: FileActions, filePath: URL, useCase: RepUseCase) {
        self.actions = actions
        self.filePath = filePath
        self.useCase = useCase
        self.settings = SettingsStorageImpl.shared.codeOptions
    }
}

// MARK: - FileViewModelInput
extension FileViewModelImpl {
    func viewDidLoad() {
        fetchContent()
    }

    func copyFilePath() {
        guard let file = file.value?.path else {
            assert(false, "no file path")
            return
        }
        actions.copy(file)
    }

    func share() {
        actions.share(filePath)
    }

    func openCodeOptions() {
        actions.openCodeOptions()
    }
}

// MARK: - private
private extension FileViewModelImpl {
    func fetchContent() {
        useCase.fetchFile(path: filePath) { result in
            switch result {
            case .success(let file):
                self.file.value = file
            case .failure(let error):
                self.handle(error)
            }
        }
    }

    func handle(_ error: Error) {}
}
