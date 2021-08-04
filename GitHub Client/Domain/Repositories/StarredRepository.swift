//
//  StarredRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol StarredRepository {
    func fetchStarred(page: Int, login: String, completion: @escaping (Result<[Repository], Error>) -> Void)
}
