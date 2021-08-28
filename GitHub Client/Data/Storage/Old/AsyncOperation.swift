//
//  CoreDataManagerOperation.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import Foundation

class AsyncOperation: Operation {
    @objc enum OpeerationState: Int {
        case pending
        case executing
        case finished
    }

    typealias CompletionHandler = () -> Void
    typealias OperationBlock = (@escaping CompletionHandler) -> Void

    private let operationBlock: OperationBlock

    init(operationBlock: @escaping OperationBlock) {
        self.operationBlock = operationBlock
    }

    @objc dynamic fileprivate(set) var state: OpeerationState = .pending

    @objc dynamic class func keyPathsForValuesAffectingIsExecuting() -> Set<String> {
        return Set<String>(["state"])
    }

    @objc dynamic class func keyPathsForValuesAffectingIsFinished() -> Set<String> {
        return Set<String>(["state"])
    }

    @objc override dynamic var isAsynchronous: Bool {
        return true
    }

    @objc override dynamic var isExecuting: Bool {
        return self.state == .executing
    }

    @objc override dynamic var isFinished: Bool {
        return self.state == .finished
    }

    override func start() {
        guard self.state == .pending else {
            return
        }

        guard !self.isCancelled else {
            return
        }

        guard self.isReady else {
            return
        }

        self.state = .executing
        self.operationBlock {
            self.state = .finished
        }
    }
}
