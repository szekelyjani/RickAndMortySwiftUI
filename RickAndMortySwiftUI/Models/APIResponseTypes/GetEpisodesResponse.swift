//
//  GetEpisodesResponse.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 29..
//

import Foundation

struct GetEpisodesResponse: Codable {
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
    
}
