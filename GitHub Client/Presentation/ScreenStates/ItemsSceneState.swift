//
//  ItemsSceneState.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 26.08.2021.
//

import UIKit

enum ItemsSceneState<Item> {
    case loaded(items: [Item], indexPaths: [IndexPath])
    case loading
    case loadingNext
    case refreshing
    case error(error: Error)
}
