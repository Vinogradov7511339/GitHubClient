//
//  NetworkingProtocol.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 01.08.2021.
//
import Foundation

public typealias RequestHeaders = [String: String]
public typealias RequestParameters = [String: String]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol EndpointProtocol {
    var path: URL { get }
    var method: RequestMethod { get }
    var headers: RequestHeaders { get }
    var parameters: RequestParameters { get }
    var jsonBody: Data? { get }
}

