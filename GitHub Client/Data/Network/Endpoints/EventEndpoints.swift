//
//  EventEndpoints.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventEndpoints {
    static func events(_ model: EventsRequestModel) -> Endpoint<[EventResponseDTO]> {
        let page = model.page
        return Endpoint(path: "events",
                        queryParametersEncodable: ["page": page])
    }
}
