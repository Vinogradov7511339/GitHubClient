//
//  BranchesResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

struct BranchesResponseModel {
    let branches: [Branch]
    let lastPage: Int
}
