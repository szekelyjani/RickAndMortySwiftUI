//
//  RMCharacterStatus.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 26..
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
