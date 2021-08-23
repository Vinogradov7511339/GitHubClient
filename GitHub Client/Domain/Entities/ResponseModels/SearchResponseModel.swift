//
//  SearchResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.08.2021.
//

import Foundation

struct SearchResponseModel<Item> {
    let items: [Item]
    let lastPage: Int
    let total: Int
}
