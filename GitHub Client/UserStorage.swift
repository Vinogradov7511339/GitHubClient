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
        case logged(token: String)
        case notLogged
    }
    
    static let shared = UserStorage()
    
    var loginState: LoginState {
        if let token = token {
            return .logged(token: token)
        } else {
            return .notLogged
        }
    }
    
    var token: String? {
        let ud = UserDefaults.standard
        let token = ud.string(forKey: "ACCESS_TOKEN")
        return token
    }
    
    func saveTokenResponse(_ response: TokenResponse) {
        let ud = UserDefaults.standard
        ud.setValue(response.refresh_token, forKey: "REFRESH_TOKEN")
        ud.setValue(response.access_token, forKey: "ACCESS_TOKEN")
        ud.setValue(response.expires_in, forKey: "EXPIRES_IN")
        ud.setValue(response.refresh_token_expires_in, forKey: "REFRESH_TOKEN_EXPIRES_IN")
    }
    
    func clearStorage() {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: "REFRESH_TOKEN")
        ud.removeObject(forKey: "ACCESS_TOKEN")
        ud.removeObject(forKey: "EXPIRES_IN")
        ud.removeObject(forKey: "REFRESH_TOKEN_EXPIRES_IN")
    }
}
