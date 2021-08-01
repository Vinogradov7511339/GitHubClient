//
//  RepositoryDetailsInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.08.2021.
//

import Foundation

protocol RepositoryDetailsInteractorInput {
    var output: RepositoryDetailsInteractorOutput? { get set }
    
    func fetchReadMe()
}

protocol RepositoryDetailsInteractorOutput: AnyObject {
    func didReceive(readMe: String)
}

class RepositoryDetailsInteractor {
    weak var output: RepositoryDetailsInteractorOutput?
    
    private let service = ServicesManager.shared.repositoryService
    private var repository: Repository
    
    init(_ repository: Repository) {
        self.repository = repository
    }
}

// MARK: - RepositoryDetailsInteractorInput
extension RepositoryDetailsInteractor: RepositoryDetailsInteractorInput {
    func fetchReadMe() {
        service.fetchReadMe(for: repository) { readMe, error in
            guard let readMe = readMe else { return } //todo
            guard let decoded = readMe.content.fromBase64() else { return }
            self.output?.didReceive(readMe: decoded)
        }
    }
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}
