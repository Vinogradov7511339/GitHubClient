//
//  TokenService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 23.07.2021.
//

import Foundation


class TokenService: NetworkService {
    
    func renewToken(authCode: String, completion: @escaping (TokenResponse?, Error?) -> Void) {
        guard let refresh_token = UserStorage.shared.token else {
            completion(nil, nil)
            return
        }
        let postParams = "refresh_token=" + refresh_token + "&grant_type=refresh_token" + "&client_id=" + GithubConstants.CLIENT_ID + "&client_secret=" + GithubConstants.CLIENT_SECRET
        let postData = postParams.data(using: String.Encoding.utf8)
        let path = "https://github.com/login/oauth/access_token"
        let verify: NSURL = NSURL(string: path)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse)
            }
            if let data = data, let tokenResponse = self.decode(of: TokenResponse.self, from: data) {
                completion(tokenResponse, nil)
                return
            }
            completion(nil, error)
        }
        task.resume()
    }
    
    func fetchToken(authCode: String, completion: @escaping (TokenResponse?, Error?) -> Void) {
        let endpoint = Endpoint.login(authCode: authCode)

        let params = endpoint.query
        guard let bodyParams = params.percentEncoded() else {
            completion(nil, nil)
            return
        }
        
        let request = NSMutableURLRequest(url: endpoint.path)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = bodyParams
        endpoint.headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        self.request(request as URLRequest) { data, response, error in
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
