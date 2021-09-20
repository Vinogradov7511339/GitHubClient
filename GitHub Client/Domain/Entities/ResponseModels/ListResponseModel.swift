//
//  ListResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

struct ListResponseModel<Item> {
    let items: [Item]
    let lastPage: Int
}

extension ListResponseModel {
    init(_ items: [Item], response: HTTPURLResponse?) {
        self.items = items
        self.lastPage = response?.lastPage ?? 1
    }
}
