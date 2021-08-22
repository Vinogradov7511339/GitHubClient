//
//  ExploreTempRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

protocol ExploreTempRepository {
    typealias RepositoriesHandler = (Result<ListResponseModel<Repository>, Error>) -> Void
    func fetch(_ searchModel: SearchRequestModel, completion: @escaping RepositoriesHandler)
}
