//
//  ImageCacheManager.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 12. 10..
//

import SwiftUI

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getImage(for url: String) -> UIImage? {
        let cacheKey = NSString(string: url)
        return cache.object(forKey: cacheKey)
    }
    
    func saveImage(_ image: UIImage, for url: String) {
        let cacheKey = NSString(string: url)
        cache.setObject(image, forKey: cacheKey)
    }
}
