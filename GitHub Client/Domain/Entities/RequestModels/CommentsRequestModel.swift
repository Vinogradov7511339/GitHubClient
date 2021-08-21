//
//  CommentsRequestModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

struct CommentsRequestModel<Item> {
    let item: Item
    let page: Int
}
