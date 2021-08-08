//
//  HomeRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

import Foundation

protocol HomeRepository {
    func fetchRecent(completion: @escaping(Result<[IssueResponseDTO], Error>) -> Void)
}
