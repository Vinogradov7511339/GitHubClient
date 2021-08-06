//
//  FilePresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 02.08.2021.
//

import UIKit

protocol FilePresenterInput {
    var output: FilePresenterOutput? { get set }

    func viewDidLoad()
}

protocol FilePresenterOutput: AnyObject {
    func display(text: String)
}

class FilePresenter {
    var output: FilePresenterOutput?
    
    private let service = ServicesManager.shared.repositoryService
    private let filePath: URL
    
    init(_ filePath: URL) {
        self.filePath = filePath
    }
}

// MARK: - FilePresenterInput
extension FilePresenter: FilePresenterInput {
    func viewDidLoad() {
        fetchContent()
    }
}

// MARK: - private
private extension FilePresenter {
    func fetchContent() {
        service.fetchFile(filePath: filePath) { file, error in
            if let file = file {
                let decoded = file.content.fromBase64()
                DispatchQueue.main.async {
                    self.output?.display(text: decoded ?? "NaN")
                }
            }
        }
    }
}
