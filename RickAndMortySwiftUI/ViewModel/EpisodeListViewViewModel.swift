//
//  EpisodeListViewViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 29..
//

import Foundation

@MainActor
class EpisodeListViewViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published var loadingState: LoadingState = .na
    var nextPageUrl: String?
    
    func getEpisodes() async {
        episodes.removeAll()
        let endpoint = "https://rickandmortyapi.com/api/episode"
        await getEpisodes(from: endpoint)
    }
    
    func getMoreEpisodes() async {
        if let nextPageUrl, loadingState == .finished {
            await getEpisodes(from: nextPageUrl)
        }
    }
    
    private func getEpisodes(from url: String) async {
        loadingState = .loading
        do {
            let result: GetEpisodesResponse = try await NetworkManager.shared.fetchData(from: url)
            nextPageUrl = result.info.next
            episodes.append(contentsOf: result.results)
            loadingState = .finished
        } catch {
            if let nError = error as? NetworkError {
                print(nError.rawValue)
            }
            loadingState = .failed
        }
    }
}
