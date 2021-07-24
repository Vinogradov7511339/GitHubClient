//
//  WebImageView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 20.07.2021.
//

import UIKit

/// An object that displays a single image from internet in your interface.
/**
 * A custom view that accepts a URL and tries to find a picture along this path in the cache, if it fails, makes a request to the network, if the object has been deleted before the answer arrives, the task cancel
 */
class WebImageView: UIImageView {
    private var currentUrl: URL?
    
    private var dataTask: URLSessionDataTask?
    
    func set(url: URL?) {
        guard let url = url else {
            self.image = nil
            return
        }
        currentUrl = url
        
        if let casheResponse = URLCache.shared.cachedResponse(for:  URLRequest(url: url)) {
            self.image = UIImage(data: casheResponse.data)
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask?.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let cashedRespone = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cashedRespone, for: URLRequest(url: url))
        
        if url == currentUrl {
            self.image = UIImage(data: data)
        }
    }
    
    deinit {
        dataTask?.cancel()
    }
    
}
