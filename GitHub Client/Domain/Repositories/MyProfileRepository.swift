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

    // MARK: - Events

    typealias EventsHandler = EventsRepository.EventsHandler
    func fetchRecevedEvents(request: EventsRequestModel, completion: @escaping EventsHandler)
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler)

    // MARK: - Subscriptions

    typealias SubscriptionsHandler = (Result<ListResponseModel<Repository>, Error>) -> Void
    func fetchSubscriptions(page: Int, completion: @escaping SubscriptionsHandler)

    // MARK: - Widgets

    typealias WidgetsHandler = (Result<[HomeWidget], Error>) -> Void
    func fetchWidgets(completion: @escaping WidgetsHandler)
}
