//
//  CommitsResponseModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 18.08.2021.
//

struct CommitsResponseModel {
    let items: [ExtendedCommit]
    let lastPage: Int
}
