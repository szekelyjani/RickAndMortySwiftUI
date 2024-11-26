//
//  CharacterListViewViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 25..
//

import Foundation

enum LoadingState {
    case na
    case loading
    case finished
    case failed
}

@MainActor
class CharacterListViewViewModel: ObservableObject {
    @Published var characters: [RMCharacter] = []
    @Published var loadingState: LoadingState = .na
    var nextPageUrl: String?
    var prevPageUrl: String?
    
    func getCharacters() async {
        let endpoint = "https://rickandmortyapi.com/api/character"
        await getAllCharacters(endpoint)
    }
    func getNextCharacters() async {
        if let nextPageUrl, loadingState == .finished {
            await getAllCharacters(nextPageUrl)
        }
    }
    
    func getAllCharacters(_ endpoint: String) async {
        loadingState = .loading
        do {
            let result = try await NetworkManager.shared.getAllCharacters(from: endpoint)
            nextPageUrl = result.info.next
            prevPageUrl = result.info.prev
            characters.append(contentsOf: result.results)
        } catch {
            print("Something went wrong.")
            loadingState = .failed
        }
        loadingState = .finished
    }
}