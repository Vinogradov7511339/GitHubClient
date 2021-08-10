//
//  NetworkSessionManager.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable
}

final class NetworkSessionManagerImpl {}

// MARK: - NetworkSessionManager
extension NetworkSessionManagerImpl: NetworkSessionManager {
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
