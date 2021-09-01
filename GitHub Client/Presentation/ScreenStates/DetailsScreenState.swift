//
//  DetailsScreenState.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.08.2021.
//

import Foundation

enum DetailsScreenState<Entity> {
    case loaded(Entity)
    case loading
    case error(Error)
}
