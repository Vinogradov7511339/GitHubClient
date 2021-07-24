//
//  GitHubEndpoint.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 16.07.2021.
//

import Foundation

enum GitHubEndpoint {
    case profile(accessToken: String)
}

extension GitHubEndpoint: RequestProtocol {
    var path: String {
        switch self {
        case .profile(_):
            return "/user"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .profile(_):
            return .get
        }
    }
    
    var headers: RequestHeaders? {
        switch self {
        case .profile(let accessToken):
            return ["Authorization" : "Bearer \(accessToken)"]
        }
    }
    
    var parameters: RequestParameters? {
        switch self {
        case .profile(_):
            return nil
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .profile(_):
            return .data
        }
    }
    
    var responseType: ResponseType {
        switch self {
        case .profile(_):
            return .json
        }
    }
    
    var progressHandler: ProgressHandler? {
        get {
            switch self {
            case .profile(_):
                return nil
            }
        }
        set {
            switch self {
            case .profile(_):
                break
            }
        }
    }
}
