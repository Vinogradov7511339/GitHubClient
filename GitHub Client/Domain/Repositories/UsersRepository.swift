//
//  UsersListRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 12.08.2021.
//

import Foundation

protocol UsersRepository {
    func fetch(requestModel: UsersRequestModel,
               completion: @escaping (Result<UsersResponseModel, Error>) -> Void)
}
