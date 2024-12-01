//
//  EpisodeDetailViewViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 30..
//

import Foundation

@MainActor
class EpisodeDetailViewViewModel: ObservableObject {
    @Published var characters: [RMCharacter] = []
    
    func getRelatedCharacters(for episode: RMEpisode) async {
        characters.removeAll()
        for url in episode.characters {
            do {
                let result: RMCharacter = try await NetworkManager.shared.fetchData(from: url)
                characters.append(result)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
