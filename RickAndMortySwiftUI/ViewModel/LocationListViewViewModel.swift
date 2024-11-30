//
//  LocationListViewViewModel.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 26..
//

import Foundation

@MainActor
final class LocationListViewViewModel: ObservableObject {
    @Published var loadingState: LoadingState = .na
    @Published var locations: [RMLocation] = []
    @Published var searchText = ""
    var nextPageUrl: String?
    
    func getAllLocations() async {
        locations.removeAll()
        let endpoint = "https://rickandmortyapi.com/api/location"
        await getLocationList(from: endpoint)
    }
    
    func getMoreLocations() async {
        if let nextPageUrl, loadingState == .finished {
            await getLocationList(from: nextPageUrl)
        }
    }
    
    private func getLocationList(from endpoint: String) async {
        loadingState = .loading
        do {
            let result: GetLocationsResponse = try await NetworkManager.shared.fetchData(from: endpoint)
            nextPageUrl = result.info.next
            locations.append(contentsOf: result.results)
            loadingState = .finished
        } catch {
            loadingState = .failed
        }
    }
    
    func search() async {
        guard !searchText.isEmpty else {
            return
        }
        loadingState = .loading
        locations.removeAll()
        let enpoint = "https://rickandmortyapi.com/api/location/?name=\(searchText)"
        await getLocationList(from: enpoint)
    }
    
}
