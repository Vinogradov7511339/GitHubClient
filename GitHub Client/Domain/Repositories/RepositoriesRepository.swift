//
//  RepositoriesRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 13.08.2021.
//

import Foundation

protocol RepositoriesRepository {
    func fetch(requestModel: RepositoriesRequestModel,
               completion: @escaping (Result<RepositoriesResponseModel, Error>) -> Void)
}
