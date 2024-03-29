//
//  DataTransferService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void

    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<(model :T, httpResponse :HTTPURLResponse?)>) -> NetworkCancellable? where E.Response == T

    @discardableResult
    func request<E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<HTTPURLResponse?>) -> NetworkCancellable? where E.Response == Void
}

final class DataTransferServiceImpl {

    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    private let errorLogger: DataTransferErrorLogger

    init(with networkService: NetworkService,
         errorResolver: DataTransferErrorResolver = DataTransferErrorResolverImpl(),
         errorLogger: DataTransferErrorLogger = DataTransferErrorLoggerImpl()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

extension DataTransferServiceImpl: DataTransferService {

    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<(model: T, httpResponse :HTTPURLResponse?)>) -> NetworkCancellable? where E.Response == T {

        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                let result: Result<T, DataTransferError> = self.decode(data: response.data, decoder: endpoint.responseDecoder)
                switch result {
                case .success(let model):
                    DispatchQueue.main.async { return completion(.success((model, response.httpResponse))) }
                case .failure(let error):
                    DispatchQueue.main.async { return completion(.failure(error)) }
                }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

    func request<E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<HTTPURLResponse?>) -> NetworkCancellable? where E.Response == Void {
        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { return completion(.success((response.httpResponse))) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

    // MARK: - Private
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }

    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}
