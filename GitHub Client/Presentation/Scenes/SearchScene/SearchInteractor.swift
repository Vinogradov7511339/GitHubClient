//
//  SearchInteractor.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import Foundation


protocol SearchInteractorInput {
    var output: SearchInteractorOutput? { get set }
    
    func search(text: String, searchType: SearchType)
}

protocol SearchInteractorOutput: AnyObject {
    
}

class SearchInteractor {
    weak var output: SearchInteractorOutput?
    private let service = ServicesManager.shared.searchService
}

// MARK: - SearchInteractorInput
extension SearchInteractor: SearchInteractorInput {
    func search(text: String, searchType: SearchType) {
        fetch(text: text, searchType: searchType)
    }
}

// MARK: - private
private extension SearchInteractor {
    func fetch(text: String, searchType: SearchType) {
        service.search(text: text, type: searchType, responseType: RepositoriesResponse.self) { repositoriesResponse, error in
            print("reps \(repositoriesResponse)")
        }
    }
}
