//
//  AccountViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

struct AccountActions {
    var logout: () -> Void
}

protocol AccountViewModelInput {
    func logoutTouched()
}

protocol AccountViewModelOutput {}

typealias AccountViewModel = AccountViewModelInput & AccountViewModelOutput

final class AccountViewModelImpl: AccountViewModel {

    // MARK: - Private variables

    private let actions: AccountActions

    // MARK: - Lifecycle

    init(_ actions: AccountActions) {
        self.actions = actions
    }
}

// MARK: - Input
extension AccountViewModelImpl {
    func logoutTouched() {
        actions.logout()
    }
}
