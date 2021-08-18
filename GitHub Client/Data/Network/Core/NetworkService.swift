//
//  NetworkService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

protocol NetworkService {
    typealias ResponseType = (data: Data?, httpResponse: HTTPURLResponse?)
    typealias ResultType = Result<ResponseType, NetworkError>
    typealias CompletionHandler = (ResultType) -> Void

    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable?
}

final class NetworkServiceImpl {

    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    private let logger: NetworkErrorLogger

    init(config: NetworkConfigurable,
         sessionManager: NetworkSessionManager = NetworkSessionManagerImpl(),
         logger: NetworkErrorLogger = NetworkErrorLoggerImpl()) {
        self.sessionManager = sessionManager
        self.config = config
        self.logger = logger
    }

    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {

        let sessionDataTask = sessionManager.request(request) { data, response, requestError in

            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }

                self.logger.log(error: error)
                completion(.failure(error))
            } else {
                self.logger.log(responseData: data, response: response)
                completion(.success((data, response as? HTTPURLResponse)))
            }
        }

        logger.log(request: request)

        return sessionDataTask
    }

    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}

// MARK: - NetworkService
extension NetworkServiceImpl: NetworkService {
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
    }
}
