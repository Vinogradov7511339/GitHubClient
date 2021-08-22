//
//  EventsRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

protocol EventsRepository {

    // MARK: - Events

    typealias EventsHandler = (Result<ListResponseModel<Event>, Error>) -> Void
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler)
}
