//
//  MyProfileRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 06.08.2021.
//

protocol MyProfileRepository {
    func fetch(completion: @escaping (Result<AuthenticatedUser, Error>) -> Void)
    func fetchEvents(request: UserEventsRequestModel, completion: @escaping (Result<[Event], Error>) -> Void)
}
