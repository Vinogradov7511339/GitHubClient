//
//  IssuesEndpoits.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import Foundation
import Networking

enum IssuesEndpoits {
    case issues(parameters: IssuesFilters)
}

// MARK: - EndpointProtocol
extension IssuesEndpoits: EndpointProtocol {
    var path: URL {
        switch self {
        case .issues: return URL(string: "https://api.github.com/issues")!
        }
    }
    
    var method: RequestMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: RequestHeaders {
        switch self {
        default:
            return EndpointOld.defaultHeaders
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .issues(let model):
            var params: RequestParameters = [:]
            params["filter"] = model.filter
            params["state"] = model.state
            params["sort"] = model.sort
            params["direction"] = model.direction
            return params
        }
        
    }
    
    var jsonBody: Data? {
        switch self {
        default:
            return nil
        }
    }
}
