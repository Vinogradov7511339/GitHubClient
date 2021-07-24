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
        if let _ = token {
            return .logged
        } else {
            return .notLogged
        }
    }
    
    var token: TokenResponse? {
        let ud = UserDefaults.standard
        guard let token = ud.string(forKey: "ACCESS_TOKEN") else { return nil}
        guard let tokenType = ud.string(forKey: "TOKEN_TYPE") else { return nil }
        return TokenResponse(access_token: token, scope: "", token_type: tokenType)
    }
    
    func saveTokenResponse(_ response: TokenResponse) {
        let ud = UserDefaults.standard
        ud.setValue(response.access_token, forKey: "ACCESS_TOKEN")
        ud.setValue(response.token_type, forKey: "TOKEN_TYPE")
    }
    
    func clearStorage() {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: "ACCESS_TOKEN")
        ud.removeObject(forKey: "TOKEN_TYPE")
    }
}
