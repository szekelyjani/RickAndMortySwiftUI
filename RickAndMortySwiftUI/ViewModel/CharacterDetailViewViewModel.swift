//
//  CharacterDetailViewViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 12. 11..
//

import Foundation

class CharacterDetailViewViewModel: ObservableObject {
    @Published var episodes: [RMEpisode] = []
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    let shartDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    @MainActor
    func getRelatedEpisodes(for character: RMCharacter) async {
        let list = character.episode
        for url in list {
            do {
                let result: RMEpisode = try await NetworkManager.shared.fetchData(from: url)
                episodes.append(result)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
