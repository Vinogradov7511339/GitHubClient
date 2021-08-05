//
//  RepositoryDetailsInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.08.2021.
//

import Foundation

protocol RepositoryInteractorInput {
    var output: RepositoryInteractorOutput? { get set }
    
    func fetchRepositoryInfo()
}

protocol RepositoryInteractorOutput: AnyObject {
    func didReceive(repositoryInfo: RepositoryInfo)
}

class RepositoryInteractor {
    weak var output: RepositoryInteractorOutput?
    
    private let repositoryService = ServicesManager.shared.repositoryService
    private let repositoryFacade: RepositoryFacade
    private var repository: RepositoryResponse
    
    init(_ repository: RepositoryResponse) {
        self.repository = repository
        self.repositoryFacade = RepositoryFacade(repository)
    }
}

// MARK: - RepositoryInteractorInput
extension RepositoryInteractor: RepositoryInteractorInput {
    func fetchRepositoryInfo() {
        repositoryFacade.fetchInfo { info, error in
            if let info = info {
                self.output?.didReceive(repositoryInfo: info)
            }
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
