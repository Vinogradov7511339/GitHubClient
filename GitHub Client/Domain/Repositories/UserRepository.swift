//
//  UserRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.08.2021.
//

import Foundation

protocol UserRepository {

    // MARK: - Users

    typealias UsersHandler = (Result<ListResponseModel<User>, Error>) -> Void
    func fetchFollowers(request: UsersRequestModel, completion: @escaping UsersHandler)
    func fetchFollowing(request: UsersRequestModel, completion: @escaping UsersHandler)

    // MARK: - User Profile

    typealias ProfileHandler = (Result<UserProfile, Error>) -> Void
    func fetchProfile(_ user: User, completion: @escaping ProfileHandler)

    // MARK: - User Repositories

    typealias RepListHandler = RepRepository.RepListHandler
    func fetchRepList(request: UsersRequestModel, completion: @escaping RepListHandler)
    func fetchStarred(request: UsersRequestModel, completion: @escaping RepListHandler)

    // MARK: - User Events

    typealias EventsHandler = EventsRepository.EventsHandler
    func fetchRecevedtEvents(request: EventsRequestModel, completion: @escaping EventsHandler)
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler)
}
