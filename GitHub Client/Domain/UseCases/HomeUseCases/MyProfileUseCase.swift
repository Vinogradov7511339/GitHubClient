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

    // MARK: - Users

    typealias UsersHandler = MyProfileRepository.UsersHandler
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

    func fetchFollowers(page: Int, completion: @escaping UsersHandler) {
        profileRepository.fetchFollowers(page: page, completion: completion)
    }

    func fetchFollowing(page: Int, completion: @escaping UsersHandler) {
        profileRepository.fetchFollowing(page: page, completion: completion)
    }

    func fetchRepList(page: Int, completion: @escaping RepListHandler) {
        profileRepository.fetchRepList(page: page, completion: completion)
    }

    func fetchStarred(page: Int, completion: @escaping RepListHandler) {
        profileRepository.fetchStarred(page: page, completion: completion)
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
