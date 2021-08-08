//
//  HomeRepositoryImpl.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

final class HomeRepositoryImpl {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

// MARK: - HomeRepository
extension HomeRepositoryImpl: HomeRepository {
    func fetchRecent(completion: @escaping (Result<[IssueResponseDTO], Error>) -> Void) {

    }
}
