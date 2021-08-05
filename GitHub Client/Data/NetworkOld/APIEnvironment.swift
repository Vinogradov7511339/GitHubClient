//
//  APIEnvironment.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.07.2021.
//
import Networking

protocol EnvironmentProtocol {
    var headers: RequestHeaders? { get }
    var baseURL: String { get }
}

enum APIEnvironment: EnvironmentProtocol {
    case development
    case production
    
    var headers: RequestHeaders? {
        switch self {
        case .development:
            return [
                "Content-Type" : "application/json",
            ]
        case .production:
            return [
                "Content-Type" : "application/json",
            ]
        }
    }
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://api.github.com"
        case .production:
            return "https://api.github.com"
        }
    }
}
