//
//  Logger.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

final class NetworkErrorLoggerImpl {
    private typealias HTTPBodyDict = [String: AnyObject]
}

// MARK: - NetworkErrorLogger
extension NetworkErrorLoggerImpl: NetworkErrorLogger {
    func log(request: URLRequest) {
        print("-------------")
        print("request: \(request.url!)")
        print("headers: \(request.allHTTPHeaderFields!)")
        print("method: \(request.httpMethod!)")
        guard let httpBody = request.httpBody else {
            printIfDebug("NetworkErrorLogger: no body")
            return
        }

        if let result = (try? JSONSerialization.jsonObject(with: httpBody, options: []) as? HTTPBodyDict) {
            printIfDebug("NetworkErrorLogger: body: \(String(describing: result))")
        } else if let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("NetworkErrorLogger: body: \(String(describing: resultString))")
        }
    }

    func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            printIfDebug("NetworkErrorLogger responseData: \(String(describing: dataDict))")
        }
    }

    func log(error: Error) {
        printIfDebug("\(error)")
    }
}
