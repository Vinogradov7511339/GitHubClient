//
//  RepRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepRepository {
    func fetchCommits(request: CommitsRequestModel, completion: @escaping (Result<CommitsResponseModel, Error>) -> Void)
}
