//
//  DataTransferErrorLogger.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

protocol DataTransferErrorLogger {
    func log(error: Error)
}

final class DataTransferErrorLoggerImpl {}

// MARK: - DataTransferErrorLogger
extension DataTransferErrorLoggerImpl: DataTransferErrorLogger {
    func log(error: Error) {
        printIfDebug("-------------")
        printIfDebug("\(error)")
    }
}
