//
//  GetAllCharactersResponse.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import Foundation

struct GetAllCharactersResponse: Codable {
    let info: Info
    let results: [RMCharacter]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

enum GetAllCharactersResponseError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
