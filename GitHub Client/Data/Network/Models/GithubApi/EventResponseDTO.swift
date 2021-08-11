//
//  EventResponseDTO.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct EventResponseDTO: Codable {

    let id: String
    let type: String
    let `public`: Bool
//    let payload: Any?
    let repo: RepositoryResponseDTO?
    let actor: UserResponseDTO?
    let org: OrganzationResponseDTO?
    let createdAt: String

    func toDomain() -> Event? {
        guard let intId = Int(id) else {
            return nil
        }
        guard let eventType = Event.Types(rawValue: type) else {
            return nil
        }
        guard let user = actor?.toDomain() else {
            return nil
        }
        return Event(id: intId, eventType: eventType, actor: user)
    }
}
