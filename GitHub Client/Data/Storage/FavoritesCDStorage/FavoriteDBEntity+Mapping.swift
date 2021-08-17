//
//  FavoriteDBEntity+Mapping.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import CoreData

extension FavoriteCDEntity {
    convenience init(_ repository: Repository, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        repositoryId = Int64(repository.repositoryId)
        owner = UserCDEntity(repository.owner, insertInto: context)
        name = repository.name
        starsCount = Int64(repository.starsCount)
        detailText = repository.description
        language = repository.language
    }

    func toDomain() -> Repository? {
        guard let name = name else {
            return nil
        }
        guard let owner = self.owner?.toDomain() else {
            return nil
        }
        return .init(
            repositoryId: Int(repositoryId),
            owner: owner,
            name: name,
            starsCount: Int(starsCount),
            forksCount: -1,
            openIssuesCount: -1,
            description: detailText,
            language: language,
            hasIssues: false
        )
    }
}
