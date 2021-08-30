//
//  EventsRequestModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

import Foundation

struct EventsRequestModel {
    let path: URL
    let page: Int
    let perPage: Int
}
