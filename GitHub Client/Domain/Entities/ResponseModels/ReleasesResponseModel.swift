//
//  ReleasesResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

struct ReleasesResponseModel {
    let items: [Release]
    let lastPage: Int
}
