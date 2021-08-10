//
//  GitHub_ClientTests.swift
//  GitHub ClientTests
//
//  Created by Alexander Vinogradov on 10.08.2021.
//

import XCTest
@testable import GitHub_Client

// swiftlint:disable colon
class GitHub_ClientTests: XCTestCase {

    private var coreStorage: CoreDataStorage!
    private var favoritesStorage: FavoritesStorage!

    override func setUpWithError() throws {
        try super.setUpWithError()
        coreStorage = CoreDataStorage()
        favoritesStorage = FavoritesStorageImpl(coreDataStorage: coreStorage)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        coreStorage = nil
        favoritesStorage = nil
    }

    func testExample() throws {
        let user = User(id: 1,
                        avatarUrl: URL(string: "https://www.google.com")!,
                        login: "User",
                        name: "Name",
                        bio: "Bio")
        let repository = Repository(repositoryId: 1,
                                    owner: user,
                                    name: "repo",
                                    starsCount: 4,
                                    description: "test",
                                    language: "swift")
        // todo after
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
