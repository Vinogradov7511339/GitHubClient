//
//  IssueEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import Foundation

struct IssueEndpoints {
    static func getComments(model: IssueRequestModel) -> Endpoint<[CommentResponseDTO]> {
        return Endpoint(path: model.issue.commentsURL.absoluteString,
                        isFullPath: true,
                        queryParametersEncodable: ["page": model.page])
    }

    
}
