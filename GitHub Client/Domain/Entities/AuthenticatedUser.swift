//
//  AuthenticatedUser.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

struct AuthenticatedUser {
    let userDetails: UserProfile
    let totalRepCount: Int
    let totalOwnedRepCount: Int
}
