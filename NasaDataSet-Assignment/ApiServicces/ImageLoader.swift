//
//  ImageLoader.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    private init() {}
    private var imageCache = NSCache<NSString, UIImage>()

    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let newImage = UIImage(data: data) else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.invalidData))
                }
                return
            }
            self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
            completion(.success(newImage))
        }.resume()
    }
}
