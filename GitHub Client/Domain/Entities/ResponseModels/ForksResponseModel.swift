//
//  ForksResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

struct ForksResponseModel {
    let forks: [Repository]
    let lastPage: Int
}
