//
//  MyProfileUseCase.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

protocol MyProfileUseCase {

    // MARK: - Profile

    typealias ProfileHandler = MyProfileRepository.ProfileHandler
    func fetchProfile(completion: @escaping ProfileHandler)

    // MARK: - Events

    typealias EventsHandler = EventsRepository.EventsHandler
    func fetchRecevedEvents(request: EventsRequestModel, completion: @escaping EventsHandler)
    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler)

    // MARK: - Subscriptions

    typealias SubscriptionsHandler = MyProfileRepository.SubscriptionsHandler
    func fetchSubscriptions(page: Int, completion: @escaping SubscriptionsHandler)
}

final class MyProfileUseCaseImpl {
    let profileRepository: MyProfileRepository

    init(profileRepository: MyProfileRepository) {
        self.profileRepository = profileRepository
    }
}

// MARK: - MyProfileUseCase
extension MyProfileUseCaseImpl: MyProfileUseCase {
    func fetchProfile(completion: @escaping ProfileHandler) {
        profileRepository.fetchProfile(completion: completion)
    }

    func fetchRecevedEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        profileRepository.fetchRecevedEvents(request: request, completion: completion)
    }

    func fetchEvents(request: EventsRequestModel, completion: @escaping EventsHandler) {
        profileRepository.fetchEvents(request: request, completion: completion)
    }

    func fetchSubscriptions(page: Int, completion: @escaping SubscriptionsHandler) {
        profileRepository.fetchSubscriptions(page: page, completion: completion)
    }
}
