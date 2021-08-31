//
//  UserRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

protocol UserRepository {

    // MARK: - User Profile

    typealias ProfileHandler = (Result<UserProfile, Error>) -> Void
    func fetchProfile(_ userUrl: URL, completion: @escaping ProfileHandler)

    // MARK: - User Events

    typealias EventsHandler = EventsRepository.EventsHandler
    func fetchRecevedtEvents(request: EventsRequestModel, completion: @escaping EventsHandler)
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler)
}
