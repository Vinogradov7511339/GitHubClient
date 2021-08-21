//
//  MySubscriptionsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import UIKit

protocol MySubscriptionsViewModelInput {
    func viewDidLoad()
}

protocol MySubscriptionsViewModelOutput {
    var title: Observable<String> { get }
    var repositories: Observable<[Repository]> { get }
}

typealias MySubscriptionsViewModel = MySubscriptionsViewModelInput & MySubscriptionsViewModelOutput

final class MySubscriptionsViewModelImpl: MySubscriptionsViewModel {

    // MARK: - Output

    var title: Observable<String>
    var repositories: Observable<[Repository]> = Observable([])

    // MARK: - Private variables

    private let myProfileUseCase: MyProfileUseCase
    private var currentPage = 1
    private var lastPage: Int?

    // MARK: - Lifecycle

    init(myProfileUseCase: MyProfileUseCase) {
        self.myProfileUseCase = myProfileUseCase
        let title = NSLocalizedString("My Subscriptions", comment: "")
        self.title = Observable(title)
    }
}

// MARK: - Input
extension MySubscriptionsViewModelImpl {
    func viewDidLoad() {
        fetch()
    }
}

// MARK: - Private
private extension MySubscriptionsViewModelImpl {
    func fetch() {
        myProfileUseCase.fetchSubscriptions(page: currentPage) { result in
            switch result {
            case .success(let response):
                self.lastPage = response.lastPage
                self.repositories.value.append(contentsOf: response.items)
            case .failure(let error):
                self.handle(error)
            }
        }
    }

    func handle(_ error: Error) {
        assert(false, error.localizedDescription)
    }
}
