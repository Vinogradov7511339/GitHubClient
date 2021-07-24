//
//  ProfileService.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 16.07.2021.
//

import Foundation

class ProfileService: NetworkService {
    
    private let requestDispatcher = APIRequestDispatcher(environment: APIEnvironment.production, networkSession: APINetworkSession())
    
    
    func getProfile(completion: @escaping (UserProfile?, Error?) -> Void) {
        guard let url = URL(string: "https://api.github.com/user") else { return }
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        for header in Endpoint.myProfile.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        request.cachePolicy = .reloadIgnoringCacheData
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [weak self] data, response, error in
            guard let self = self else { return }
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
        task.resume()
    }
}
