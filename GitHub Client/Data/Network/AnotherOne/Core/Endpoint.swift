//
//  Endpoint.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 07.08.2021.
//

import Foundation

protocol ResponseRequestable: Requestable {
    associatedtype Response
    var responseDecoder: ResponseDecoder { get }
}

class Endpoint<R>: ResponseRequestable {
    typealias Response = R

    let path: String
    let isFullPath: Bool
    let method: HTTPMethodType
    let headerParamaters: QueryType
    let queryParametersEncodable: Encodable?
    let queryParameters: BodyType
    let bodyParamatersEncodable: Encodable?
    let bodyParamaters: BodyType
    let bodyEncoding: BodyEncoding
    let responseDecoder: ResponseDecoder

    init(path: String,
         isFullPath: Bool = false,
         method: HTTPMethodType = .get,
         headerParamaters: QueryType = [:],
         queryParametersEncodable: Encodable? = nil,
         queryParameters: BodyType = [:],
         bodyParamatersEncodable: Encodable? = nil,
         bodyParamaters: BodyType = [:],
         bodyEncoding: BodyEncoding = .jsonSerializationData,
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParamatersEncodable = bodyParamatersEncodable
        self.bodyParamaters = bodyParamaters
        self.bodyEncoding = bodyEncoding
        self.responseDecoder = responseDecoder
    }
}
