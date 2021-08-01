//
//  TokenService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import Foundation
import Networking


class TokenService: NetworkService {
    
    func fetchToken(authCode: String, completion: @escaping (TokenResponse?, Error?) -> Void) {
        let endpoint = Endpoint.login(authCode: authCode)
        request(endpoint) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            if let tokenResponse = self.decode(of: TokenResponse.self, from: data) {
                completion(tokenResponse, error)
                return
            } else if let errorResponse = self.decode(of: ErrorResponse.self, from: data) {
                NotificationCenter.default.post(name: Notification.Name.NetworkService.CriticalError, object: nil, userInfo: ["errorInfo" : errorResponse])
                completion(nil, error)
                return
            }
            completion(nil, error)
        }
    }
}
