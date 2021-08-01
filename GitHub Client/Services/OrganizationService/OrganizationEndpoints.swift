//
//  OrganizationEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation
import Networking

enum OrganizationEndpoints {
    
}

// MARK: - EndpointProtocol
extension OrganizationEndpoints: EndpointProtocol {
    var path: URL {
        fatalError()
    }
    
    var method: RequestMethod {
        .get
    }
    
    var headers: RequestHeaders {
        return Endpoint.defaultHeaders
    }
    
    var parameters: RequestParameters {
        return [:]
    }
    
    var jsonBody: Data? {
        return nil
    }
    
    
}
