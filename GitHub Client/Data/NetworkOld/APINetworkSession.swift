//
//  APINetworkSession.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.07.2021.
//

import Foundation
import Networking

typealias DownloadHandler = (URL?, URLResponse?, Error?) -> Void

protocol NetworkSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping ResponseHandler) -> URLSessionDataTask?
    func downloadTask(request: URLRequest, progressHandler: ProgressHandler?, completionHandler: @escaping DownloadHandler) -> URLSessionDownloadTask?
    func uploadTask(with request: URLRequest, from fileURL: URL, progressHandler: ProgressHandler?, completionHandler: @escaping ResponseHandler) -> URLSessionUploadTask?
}

class APINetworkSession: NSObject {
    
    var session: URLSession!
    
    private typealias ProgressAndCompletionHandler = (progress: ProgressHandler?, completion: (DownloadHandler?))
    private var taskToHandlersMap: [URLSessionTask: ProgressAndCompletionHandler] = [:]
    
    public convenience override init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30.0
        if #available(iOS 11.0, *) {
            sessionConfiguration.waitsForConnectivity = true
        }
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated
        
        self.init(configuration: sessionConfiguration, delegateQueue: queue)
    }
    
    public init(configuration: URLSessionConfiguration, delegateQueue: OperationQueue) {
        super.init()
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }
    
    private func set(handlers: ProgressAndCompletionHandler?, for task: URLSessionTask) {
        taskToHandlersMap[task] = handlers
    }
    
    private func getHandlers(for task: URLSessionTask) -> ProgressAndCompletionHandler? {
        return taskToHandlersMap[task]
    }
    
    deinit {
        //invalidate the session because URLSession strongly retains its delegate. https://developer.apple.com/documentation/foundation/urlsession/1411538-invalidateandcancel
        session.invalidateAndCancel()
        session = nil
    }
}

// MARK: - NetworkSessionProtocol
extension APINetworkSession: NetworkSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping ResponseHandler) -> URLSessionDataTask? {
        return session.dataTask(with: request, completionHandler: completionHandler)
    }
    
    func downloadTask(request: URLRequest, progressHandler: ProgressHandler? = nil, completionHandler: @escaping DownloadHandler) -> URLSessionDownloadTask? {
        let task = session.downloadTask(with: request)
        set(handlers: (progressHandler, completionHandler), for: task)
        return task
    }
    
    func uploadTask(with request: URLRequest, from fileURL: URL, progressHandler: ProgressHandler?, completionHandler: @escaping ResponseHandler) -> URLSessionUploadTask? {
        let task = session.uploadTask(with: request, fromFile: fileURL, completionHandler: completionHandler)
        set(handlers: (progressHandler, nil), for: task)
        return task
    }
}

// MARK: - URLSessionDownloadDelegate
extension APINetworkSession: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let handlers = getHandlers(for: downloadTask) else { return }
        
        DispatchQueue.main.async {
            handlers.completion?(location, downloadTask.response, downloadTask.error)
        }
        set(handlers: nil, for: downloadTask)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let handlers = getHandlers(for: downloadTask) else { return }
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            handlers.progress?(progress)
        }
    }
}

// MARK: - URLSessionDelegate
extension APINetworkSession: URLSessionDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let downloadTask = task as? URLSessionDownloadTask, let handlers = getHandlers(for: downloadTask) else {
            return
        }
        
        DispatchQueue.main.async {
            handlers.completion?(nil, downloadTask.response, downloadTask.error)
        }
        set(handlers: nil, for: task)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let handlers = getHandlers(for: task) else { return }
        
        let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        DispatchQueue.main.async {
            handlers.progress?(progress)
        }
        set(handlers: nil, for: task)
    }
}
