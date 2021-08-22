//
//  ExploreTempViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreTempViewModelInput {
    func viewDidLoad()
}

protocol ExploreTempViewModelOutput {
    var error: Observable<Error?> { get }
}

typealias ExploreTempViewModel = ExploreTempViewModelInput & ExploreTempViewModelOutput

final class ExploreTempViewModelImpl: ExploreTempViewModel {

    // MARK: - Output

    var error: Observable<Error?> = Observable(nil)

    // MARK: - Private variables

    private let useCase: ExploreTempUseCase

    // MARK: - Lifecycle

    init(useCase: ExploreTempUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Input
extension ExploreTempViewModelImpl {
    func viewDidLoad() {
        useCase.fetch { result in
            switch result {
            case .success(let response):
                print(response.items)
            case.failure(let error):
                self.handle(error)
            }
        }
    }
}

// MARK: - Private
private extension ExploreTempViewModelImpl {
    func handle(_ error: Error) {
        self.error.value = error
    }
}
