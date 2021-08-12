//
//  UsersListRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import Foundation

protocol UsersListRepository {
    func fetch(requestModel: UsersListRequestModel,
               completion: @escaping (Result<UsersListResponseModel, Error>) -> Void)
}
