//
//  LoginEndpoint.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import Foundation

struct LoginEndpoint {
    static func token(authCode: String) -> Endpoint<TokenResponse> {
        var headers: [String: String] = [:]
        headers["Accept"] = "application/json"

        var query: [String: String] = [:]
        query["grant_type"] = "authorization_code"
        query["code"] = authCode
        query["client_id"] = GithubConstants.clientId
        query["client_secret"] = GithubConstants.clientSecret

        return Endpoint(path: "https://github.com/login/oauth/access_token",
                 isFullPath: true,
                 method: .post,
                 headerParamaters: headers,
                 bodyParamatersEncodable: query,
//                 bodyParamaters: <#T##BodyType#>,
                 bodyEncoding: .stringEncodingAscii)
    }
}
