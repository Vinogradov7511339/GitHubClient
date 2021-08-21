//
//  RepositoryFacade.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.08.2021.
//

import Foundation

protocol RepositoryFacade {
    func fetchDetails(repository: Repository, completion: @escaping (Result<RepositoryDetails, Error>) -> Void)
}

final class RepositoryFacadeImpl {

    private let repRepository: RepRepository
    private let dispatchGroup: DispatchGroup

    private var readMe: String?
    private var error: Error?

    init(repRepository: RepRepository) {
        self.repRepository = repRepository
        self.dispatchGroup = DispatchGroup()
    }
}

// MARK: - RepositoryFacade
extension RepositoryFacadeImpl: RepositoryFacade {
    func fetchDetails(repository: Repository, completion: @escaping (Result<RepositoryDetails, Error>) -> Void) {
        fetchReadMe(repository)
        dispatchGroup.notify(queue: .main) {
//            if let error = self.error {
//                completion(.failure(error))
//                return
//            }
            if let readMe = self.readMe {
                let details = RepositoryDetails(repository: repository, mdText: readMe)
                completion(.success(details))
            } else {
                let details = RepositoryDetails(repository: repository, mdText: nil)
                completion(.success(details))
            }
        }

    }
}

// MARK: - Private
private extension RepositoryFacadeImpl {
    func fetchReadMe(_ repository: Repository) {
        dispatchGroup.enter()
        repRepository.fetchReadMe(repository: repository) { result in
            switch result {
            case .success(let readMeFile):
                self.readMe = readMeFile.content
            case .failure(let error):
                self.error = error
            }
            self.dispatchGroup.leave()
        }
    }
}
