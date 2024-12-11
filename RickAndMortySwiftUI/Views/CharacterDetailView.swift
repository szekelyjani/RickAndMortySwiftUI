//
//  CharacterDetailView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 12. 11..
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject private var viewMopdel = CharacterDetailViewViewModel()
    @State private var image: UIImage?
    let character: RMCharacter
    
    var dateValue: String {
        if let date = viewMopdel.dateFormatter.date(from: character.created) {
            return viewMopdel.shartDateFormatter.string(from: date)
        }
        return "N/A"
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(.avatar)
                        .resizable()
                        .scaledToFill()
                }
                
                Section("Personal information") {
                    FromCell(title: "Status", description: character.status.rawValue)
                    FromCell(title: "Gender", description: character.gender.rawValue)
                    FromCell(title: "Origin", description: character.origin.name)
                    FromCell(title: "Location", description: character.location.name)
                    FromCell(title: "Created", description: dateValue)
                    FromCell(title: "Episodes", description: "\(character.episode.count)")
                }
                
                if !viewMopdel.episodes.isEmpty {
                    Section("Related episodes") {
                        episodeList
                    }
                }
            }
            .navigationTitle(character.name)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                image = await NetworkManager.shared.downloadImage(from: character.image)
                await viewMopdel.getRelatedEpisodes(for: character)
                print(character.created)
            }
        }
    }
    
    private var episodeList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(viewMopdel.episodes) { episode in
                    EpisodeListCell(episode: episode)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CharacterDetailView(character: RMCharacter.Rick)
}

struct FromCell: View {
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(description)
        }
    }
}
