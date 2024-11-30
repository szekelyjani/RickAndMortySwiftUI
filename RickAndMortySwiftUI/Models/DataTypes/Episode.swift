//
//  Episode.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 29..
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    static let test_episode = Episode(id: 1,
                                        name: "Pilot",
                                        airDate: "December 2, 2013",
                                        episode: "S01E01",
                                        characters: ["https://rickandmortyapi.com/api/character/1",
                                                     "https://rickandmortyapi.com/api/character/2",
                                                     "https://rickandmortyapi.com/api/character/3",
                                                     "https://rickandmortyapi.com/api/character/4",
                                                     "https://rickandmortyapi.com/api/character/5",
                                                     "https://rickandmortyapi.com/api/character/6",
                                                     "https://rickandmortyapi.com/api/character/7",
                                                     "https://rickandmortyapi.com/api/character/8",
                                                     "https://rickandmortyapi.com/api/character/9",
                                                     "https://rickandmortyapi.com/api/character/10"],
                                        url: "https://rickandmortyapi.com/api/episode/1",
                                        created: "2017-11-10T12:56:33.798Z")
}
