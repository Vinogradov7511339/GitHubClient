//
//  Event.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 08.08.2021.
//

import Foundation

struct Event {
    let type: EventType
    let user: User
    let createdAt: Date
    let repositoryName: String
    let repositoryURL: URL
    let event: EventResponseDTO
}
