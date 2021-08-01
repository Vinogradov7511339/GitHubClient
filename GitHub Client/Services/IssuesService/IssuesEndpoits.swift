//
//  IssuesEndpoits.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import Foundation



struct IssueRequestParameters {
    var filter: String
    var state: String
    var sort: String
    var direction: String
    
    var requestParameters: RequestParameters {
        var params: RequestParameters = [:]
        params["filter"] = filter
        params["state"] = state
        params["sort"] = sort
        params["direction"] = direction
        return params
    }
//    var since: String
//    var labels = "" todo A list of comma separated label names. Example: bug,ui,@high https://docs.github.com/en/rest/reference/issues
}


enum IssuesEndpoits {
    case issues(parameters: IssueRequestParameters)
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
            return Endpoint.defaultHeaders
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
