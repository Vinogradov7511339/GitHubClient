//
//  MyProfileRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

protocol MyProfileRepository {

    // MARK: - Profile

    typealias ProfileHandler = (Result<AuthenticatedUser, Error>) -> Void
    func fetchProfile(completion: @escaping ProfileHandler)

    // MARK: - Users

    typealias UsersHandler = (Result<ListResponseModel<User>, Error>) -> Void
    func fetchFollowers(page: Int, completion: @escaping UsersHandler)
    func fetchFollowing(page: Int, completion: @escaping UsersHandler)

    // MARK: - Repositories

    typealias RepListHandler = RepRepository.RepListHandler
    func fetchRepList(page: Int, completion: @escaping RepListHandler)
    func fetchStarred(page: Int, completion: @escaping RepListHandler)

    // MARK: - Events

    typealias EventsHandler = EventsRepository.EventsHandler
    func fetchRecevedEvents(request: EventsRequestModel, completion: @escaping EventsHandler)
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler)

    // MARK: - Subscriptions
    
    typealias SubscriptionsHandler = (Result<ListResponseModel<Repository>, Error>) -> Void
    func fetchSubscriptions(page: Int, completion: @escaping SubscriptionsHandler)
}
