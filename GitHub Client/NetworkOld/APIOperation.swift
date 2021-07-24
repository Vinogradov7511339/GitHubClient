//
//  APIOperation.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 16.07.2021.
//

import Foundation

protocol OperationProtocol {
    
    associatedtype Output
    
    var request: RequestProtocol { get }
    
    func execute(in requestDispatcher: RequestDispathcerProtocol, completion: @escaping (Output) -> Void) -> Void
    func cancel() -> Void
}

enum OperationResult {
    case json(_ : Any?, _ : HTTPURLResponse?)
    case file(_ : URL?, _ : HTTPURLResponse?)
    case error(_ : Error?, _ : HTTPURLResponse?)
}



class APIOperation: OperationProtocol {
    typealias Output = OperationResult
    
    private var task: URLSessionTask?
    
    internal var request: RequestProtocol
    
    init(_ request: RequestProtocol) {
        self.request = request
    }
    
    func cancel() {
        task?.cancel()
    }
    
    func execute(in requestDispatcher: RequestDispathcerProtocol, completion: @escaping (OperationResult) -> Void) {
        task = requestDispatcher.execute(request: request, completion: completion)
    }
}
