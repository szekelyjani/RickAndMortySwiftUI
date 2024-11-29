//
//  RMLocation.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 26..
//

import Foundation

struct RMLocation: Codable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    static let test_location = RMLocation(id: 1,
                                          name: "Earth (C-137)",
                                          type: "Planet",
                                          dimension: "Dimension C-137",
                                          residents: [""],
                                          url: "",
                                          created: "")
}
