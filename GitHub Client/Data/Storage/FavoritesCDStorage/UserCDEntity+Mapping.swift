//
//  UserCDEntity+Mapping.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import CoreData

extension UserCDEntity {
    convenience init(_ user: User, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        id = Int64(user.id)
        avatarURL = user.avatarUrl
        login = user.login
        name = ""
        bio = ""
    }

    func toDomain() -> User? {
        guard let avatarURL = avatarURL else {
            return nil
        }
        guard let login = login else {
            return nil
        }
        return .init(id: 1, login: "a", avatarUrl: avatarURL, url: avatarURL, type: .user)
    }
}
