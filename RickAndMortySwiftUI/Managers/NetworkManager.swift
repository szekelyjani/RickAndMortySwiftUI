//
//  NetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import SwiftUI

final class NetworkManager {
    
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchData<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.failedToDecode
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = ImageCacheManager.shared.getImage(for: urlString) {
            return image
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            ImageCacheManager.shared.saveImage(image, for: urlString)
            return image
        } catch {
            return nil
        }
        
    }
}
