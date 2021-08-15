//
//  String+ISO8601.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 15.08.2021.
//

import Foundation

extension String {
    func toDate() -> Date? {
        ISO8601DateFormatter().date(from: self)
    }
}
