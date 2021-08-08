//
//  ServicesManager.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import Foundation

final class ServicesManager {
    
    static let shared = ServicesManager()
    
    private init() {}
    
    lazy var repositoryService: RepositoryService = {
        return RepositoryService()
    }()
    
    lazy var localStorage: LocalStorage = {
        return LocalStorage()
    }()
    
    lazy var tokenService: TokenService = {
        return TokenService()
    }()
    
    lazy var searchService: SearchService = {
        return SearchService()
    }()
    
    lazy var userService: UserService = {
        return UserService()
    }()
}
