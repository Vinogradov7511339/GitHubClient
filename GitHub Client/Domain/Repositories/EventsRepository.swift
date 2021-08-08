//
//  EventsRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

protocol EventsRepository {
    func fetchEvents(requestModel: EventsRequestModel, completion: @escaping (Result<EventsResponseModel, Error>) -> Void)
}
