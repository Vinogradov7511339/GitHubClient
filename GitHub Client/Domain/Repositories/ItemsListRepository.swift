//
//  ItemsListRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import Foundation

protocol ItemsListRepository {
    func fetch(requestModel: ItemsListRequestModel,
               completion: @escaping (Result<ItemsListResponseModel, Error>) -> Void)
}
