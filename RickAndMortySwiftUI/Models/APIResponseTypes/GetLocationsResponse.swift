//
//  GetLocationsResponse.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 26..
//

import Foundation

struct GetLocationsResponse: Codable {
    let info: Info
    let results: [RMLocation]
}
