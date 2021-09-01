//
//  ItemsSceneState.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import Foundation

enum ItemsSceneState<Item> {
    case loaded(items: [Item])
    case loading
    case error(error: Error)
}
