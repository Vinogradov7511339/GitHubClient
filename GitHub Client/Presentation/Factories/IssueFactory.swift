//
//  IssueFactory.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.08.2021.
//

import UIKit

protocol IssueFactory {
    func issueViewController() -> UIViewController
}

final class IssueFactoryImpl {}

// MARK: - IssueFactory
extension IssueFactoryImpl: IssueFactory {
    func issueViewController() -> UIViewController {
        UIViewController()
    }
}
