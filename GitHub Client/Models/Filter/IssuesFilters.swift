//
//  IssuesFilter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import Foundation
import Networking

struct IssuesFilters {
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
