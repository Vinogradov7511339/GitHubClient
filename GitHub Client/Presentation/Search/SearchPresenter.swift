//
//  SearchPresenter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import UIKit

protocol SearchPresenterInput {
    var output: SearchPresenterOutput? { get set }
    
    func didSelectItem(at indexPath: IndexPath)
}

protocol SearchPresenterOutput: AnyObject {
    var text: String { get set }
}

class SearchPresenter {
    weak var output: SearchPresenterOutput?
    var interactor: SearchInteractorInput?
}

// MARK: - SearchPresenterInput
extension SearchPresenter: SearchPresenterInput {
    func didSelectItem(at indexPath: IndexPath) {
        guard let text = output?.text else { return }
        switch indexPath.row {
        case 0:
            interactor?.search(text: text, searchType: .repositories)
        case 3:
            interactor?.search(text: text, searchType: .people)
        default:
            break
        }
    }
}


// MARK: - SearchInteractorOutput
extension SearchPresenter: SearchInteractorOutput {
}
