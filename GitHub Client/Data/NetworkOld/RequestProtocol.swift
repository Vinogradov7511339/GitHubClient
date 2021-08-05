//
//  RequestProtocol.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.07.2021.
//
import Foundation
import Networking

typealias ProgressHandler = (Float) -> Void

enum RequestType {
    case data
    case download
    case upload
}

enum ResponseType {
    case json
    case file
}

protocol RequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var headers: RequestHeaders? { get }
    var parameters: RequestParameters? { get }
    var requestType: RequestType { get }
    var responseType: ResponseType { get }
    var progressHandler: ProgressHandler? { get set }
}

extension RequestProtocol {
    public func urlRequest(with environment: EnvironmentProtocol) -> URLRequest? {
        guard let url = url(with: environment.baseURL) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonBody
        
        return request
    }
    
    private func url(with baseURL: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path += path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    private var queryItems: [URLQueryItem]? {
        guard method == .get, let parameters = parameters else {
            return nil
        }
        return parameters.map { (key: String, value: Any?) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }
    
    private var jsonBody: Data? {
        guard [.post, .put, .patch].contains(method), let parameters = parameters else {
            return nil
        }
        
        var jsonBody: Data?
        do {
            jsonBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("RequestProtocol: \(error)")
        }
        
        return jsonBody
    }
}
