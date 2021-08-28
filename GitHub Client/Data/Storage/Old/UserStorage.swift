//
//  Storage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 14.07.2021.
//

import Foundation

// todo switch to keychain
class UserStorage {

    enum LoginState {
        case logged
        case notLogged
    }

    static let shared = UserStorage()

    var loginState: LoginState {
        if token == nil {
            return .notLogged
        } else {
            return .logged
        }
    }

    var token: TokenResponse? {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "ACCESS_TOKEN") else { return nil}
        guard let tokenType = defaults.string(forKey: "TOKEN_TYPE") else { return nil }
        return TokenResponse(accessToken: token, scope: "", tokenType: tokenType)
    }

    func saveTokenResponse(_ response: TokenResponse) {
        let defaults = UserDefaults.standard
        defaults.setValue(response.accessToken, forKey: "ACCESS_TOKEN")
        defaults.setValue(response.tokenType, forKey: "TOKEN_TYPE")
    }

    func clearStorage() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "ACCESS_TOKEN")
        defaults.removeObject(forKey: "TOKEN_TYPE")
    }
}
