//
//  NetworkService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import Foundation

extension Notification.Name {
    public enum NetworkService {
        public static let CriticalError = Notification.Name(rawValue: "CriticalError")
    }
}

enum HTTPError: Error {
    case notModified
    case badRequest(String?)
    case serverError(String?)
}

enum APIError: Error {
    case noData
    case invalidResponse
    case notModified
    case parseError(String?)
    case unknown
}

typealias ResponseHandler = (Data?, URLResponse?, Error?) -> Void

class NetworkService: Error {
    private let session = URLSession.shared
    
    private func request(_ endpoint: EndpointProtocol) -> URLRequest {
        let urlWithParameters = url(url: endpoint.path, queryItems: endpoint.parameters)
        var request = URLRequest(url: urlWithParameters!)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.jsonBody
        request.cachePolicy = .reloadIgnoringCacheData //todo remove
        return request
    }
    
    func request(_ endpont: EndpointProtocol, handler: @escaping ResponseHandler) {
        let request = request(endpont)
        let task = session.dataTask(with: request) { data, response, error in
            self.check401(response: response)
            handler(data, response, error)
        }
        task.resume()
    }
    
//    func request(_ request: URLRequest,completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
//        let tast = URLSession.shared.dataTask(with: request) { data, response, error in
//            self.check401(response: response)
//            completion(data, response, error)
//        }
//        tast.resume()
//    }
    
    
    func check401(response: URLResponse?) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        if httpResponse.statusCode == 401 {
            DispatchQueue.main.async {
                ApplicationPresenter.shared.logout()
            }
        }
    }
    
    func handle(data: Data?, response: HTTPURLResponse, error: Error?) -> Result<Data, Error> {
        switch response.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(APIError.noData)
            }
        case 304:
            return .failure(HTTPError.notModified)
        case 400...499:
            return .failure(HTTPError.badRequest(error?.localizedDescription))
        case 500...599:
        return .failure(HTTPError.serverError(error?.localizedDescription))
        default:
            return .failure(APIError.unknown)
        }
    }
    
    func decode<T>(of type: T.Type, from data: Data) -> T? where T: Decodable {
        do {
            let decoder = JSONDecoder()
            let object: T = try decoder.decode(T.self, from: data)
            return object
        } catch DecodingError.dataCorrupted(let context) {
            print(DecodingError.dataCorrupted(context))
        } catch DecodingError.keyNotFound(let key, let context) {
            print(DecodingError.keyNotFound(key,context))
        } catch DecodingError.typeMismatch(let type, let context) {
            print(DecodingError.typeMismatch(type,context))
        } catch DecodingError.valueNotFound(let value, let context) {
            print(DecodingError.valueNotFound(value,context))
        } catch let error{
            print(error)
        }
        return nil
    }

    func saveCashe(for response: HTTPURLResponse, responseType: Endpoint) {
        if let lastModified = response.allHeaderFields["Last-Modified"] as? String {
            responseType.setlastModifiedDate(lastModified)
        }
        
        if let etag = response.allHeaderFields["Etag"] as? String {
            responseType.setIfNoneMatch(etag)
        }
    }
    
    func url(base baseURL: String, queryItems: [String: String] ) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            assertionFailure("url is nil")
            return nil
        }
        urlComponents.queryItems = []
        for item in queryItems {
            let queryItem = URLQueryItem(name: item.key, value: item.value)
            urlComponents.queryItems?.append(queryItem)
        }
        return urlComponents.url
    }
    
    func url(url baseURL: URL, queryItems: [String: String]) -> URL? {
        return url(base: baseURL.absoluteString, queryItems: queryItems)
    }
}
