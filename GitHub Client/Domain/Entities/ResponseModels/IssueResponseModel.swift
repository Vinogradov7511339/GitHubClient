//
//  IssueResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

struct IssueResponseModel {
    let comments: [Comment]
    let lastPage: Int
}
