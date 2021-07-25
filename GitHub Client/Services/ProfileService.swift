//
//  ProfileService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 16.07.2021.
//

import Foundation

class ProfileService: NetworkService {    
    
    func getProfile(completion: @escaping (UserProfile?, Error?) -> Void) {
        let endpoint = Endpoint.myProfile
        request(endpoint) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                fatalError("should be HTTPURLResponse")
            }
            self.saveCashe(for: response, responseType: .myProfile)
            
            let result = self.handle(data: data, response: response, error: error)
            switch result {
            case.success(let data):
                if let profile = self.decode(of: UserProfile.self, from: data) {
                    completion(profile, nil)
                } else {
                    completion(nil, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
