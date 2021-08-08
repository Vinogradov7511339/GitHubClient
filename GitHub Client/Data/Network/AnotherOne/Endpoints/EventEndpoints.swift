//
//  EventEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventEndpoints {
    static func getMyEvents(page: Int) -> Endpoint<[EventResponseDTO]> {
        return Endpoint(path: "events",
                        headerParamaters: EndpointOld.defaultHeaders,
                        queryParametersEncodable: ["page": page])
    }
}
