//
//  HTTPURLResponse+lastPage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

extension HTTPURLResponse {
    var lastPage: Int? {
        (allHeaderFields["Link"] as? String)?.lastPage
    }
}
