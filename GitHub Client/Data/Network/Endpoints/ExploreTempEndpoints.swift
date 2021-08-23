//
//  ExploreTempEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import Foundation

struct ExploreTempEndpoints {
    static func repositories(_ model: SearchRequestModel) ->
    Endpoint<SearchResponseDTO<RepositoryResponseDTO>> {
        var params: QueryType = [:]
        params["q"] = model.searchText
        params["order"] = model.order.rawValue
        params["sort"] = model.sort.rawValue
        params["per_page"] = "5"
        return Endpoint(path: "search/\(model.searchType.rawValue)", queryParametersEncodable: params)
    }

    static func users(_ model: SearchRequestModel) ->
    Endpoint<SearchResponseDTO<UserResponseDTO>> {
        var params: QueryType = [:]
        params["q"] = model.searchText
        params["order"] = model.order.rawValue
        params["sort"] = model.sort.rawValue
        params["per_page"] = "5"
        return Endpoint(path: "search/\(model.searchType.rawValue)", queryParametersEncodable: params)
    }

    static func issues(_ model: SearchRequestModel) -> Endpoint<SearchResponseDTO<IssueResponseDTO>> {
        var params: QueryType = [:]
        params["q"] = model.searchText
        params["type"] = "Issues"
//        params["q"] = "is:issue+windows+label:bug+language:python+state:open"
        params["order"] = model.order.rawValue
        params["sort"] = model.sort.rawValue
        return Endpoint(path: "search/\(model.searchType.rawValue)", queryParametersEncodable: params)
    }
}
