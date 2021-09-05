//
//  URL+Types.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 03.09.2021.
//

import Foundation

extension URL {
    var isRepository: Bool {
        pathComponents.contains("repos")
    }
}
