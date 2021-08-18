//
//  FilePresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

struct FileActions {}

protocol FileViewModelInput {
    func viewDidLoad()
}

protocol FileViewModelOutput {
    var content: Observable<String> { get }
}

typealias FileViewModel = FileViewModelInput & FileViewModelOutput

final class FileViewModelImpl: FileViewModel {

    // MARK: - Output

    var content: Observable<String> = Observable("")

    // MARK: - Private

    private let actions: FileActions
    private let filePath: URL
    private let useCase: RepUseCase
    
    init(actions: FileActions, filePath: URL, useCase: RepUseCase) {
        self.actions = actions
        self.filePath = filePath
        self.useCase = useCase
    }
}

// MARK: - FileViewModelInput
extension FileViewModelImpl {
    func viewDidLoad() {
        fetchContent()
    }
}

// MARK: - private
private extension FileViewModelImpl {
    func fetchContent() {
        useCase.fetchFile(path: filePath) { result in
            switch result {
            case .success(let file):
                self.content.value = file.content
            case .failure(let error):
                self.handle(error)
            }
        }
    }

    func handle(_ error: Error) {}
}
