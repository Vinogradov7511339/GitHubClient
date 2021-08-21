//
//  RepListResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

struct RepListResponseModel {
    let repositories: [Repository]
    let lastPage: Int
}
