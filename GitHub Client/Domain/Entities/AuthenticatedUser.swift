//
//  AuthenticatedUser.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

struct AuthenticatedUser {
    var userDetails: UserProfile
    let publicRepCount: Int
    let privateRepCount: Int
    let publicGistsCount: Int
    let privateGistsCount: Int
    let totalRepCount: Int
    let totalOwnedRepCount: Int
}
