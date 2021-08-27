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
        return Endpoint(path: path(model), queryParametersEncodable: parameters(model))
    }

    static func issues(_ model: SearchRequestModel) ->
    Endpoint<SearchResponseDTO<IssueResponseDTO>> {
        return Endpoint(path: path(model), queryParametersEncodable: parameters(model))
    }

    static func pullRequests(_ model: SearchRequestModel) ->
    Endpoint<SearchResponseDTO<PRResponseDTO>> {
        return Endpoint(path: path(model), queryParametersEncodable: parameters(model))
    }

    static func users(_ model: SearchRequestModel) ->
    Endpoint<SearchResponseDTO<UserResponseDTO>> {
        return Endpoint(path: path(model), queryParametersEncodable: parameters(model))
    }

    private static func path(_ model: SearchRequestModel) -> String {
        return "search\(model.searchType.rawValue)"
    }

    private static func parameters(_ model: SearchRequestModel) -> QueryType {
        var params: QueryType = [:]
        params["q"] = model.searchText
        params["order"] = model.order.rawValue
        params["sort"] = model.sort.rawValue
        params["per_page"] = "\(model.perPage)"
        return params
    }
}
