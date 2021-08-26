//
//  SearchFilterStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 25.08.2021.
//

enum SearchFilterType {
    case all
}

protocol SearchFilterStorage {
    func filter(for type: SearchFilterType) -> SearchFilter
}
