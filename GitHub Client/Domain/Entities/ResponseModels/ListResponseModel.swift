//
//  ListResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

struct ListResponseModel<Item> {
    let items: [Item]
    let lastPage: Int
}
