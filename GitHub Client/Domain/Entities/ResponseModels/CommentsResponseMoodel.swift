//
//  CommentsResponseMoodel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

struct CommentsResponseModel {
    let comments: [Comment]
    let lastPage: Int
}
