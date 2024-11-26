//
//  NetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getAllCharacters(from urlString: String) async throws -> GetAllCharactersResponse {
        guard let url = URL(string: urlString) else {
            throw GetAllCharactersResponseError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GetAllCharactersResponseError.invalidResponse
        }
        
        do {
            return try decoder.decode(GetAllCharactersResponse.self, from: data)
        } catch {
            throw GetAllCharactersResponseError.invalidData
        }
    }
}
