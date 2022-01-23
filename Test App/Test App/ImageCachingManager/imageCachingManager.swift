//
//  imageCachingManager.swift
//  Test App
//
//  Created by Владимир on 23.01.2022.
//

import Foundation
import UIKit

class ImageCachingManager {
    
    let urlCache = URLCache.shared
    
    static let shared = ImageCachingManager()
    private init() {}
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        if let cachedImage = urlCache.cachedResponse(for: request) {
            completion(UIImage(data: cachedImage.data))
        } else {
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil,
                      data != nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let `self` = self else {
                    return
                }
                
                guard let image = UIImage(data: data!) else { return }
                
                let responseCach = CachedURLResponse(response: response, data: data!)
                self.urlCache.storeCachedResponse(responseCach, for: request)
                
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
            dataTask.resume()
        }
    }
}
