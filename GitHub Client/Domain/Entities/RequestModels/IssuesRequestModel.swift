//
//  IssuesRequestModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

struct IssuesRequestModel {
    let page: Int
    let path: URL
    let filter: IssuesFilter
}
