//
//  EpisodeDetailView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 30..
//

import SwiftUI

struct EpisodeDetailView: View {
    @StateObject private var viewModel = EpisodeDetailViewViewModel()
    let episode: RMEpisode
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    EpisodeDetailCell(title: "Title", description: episode.name)
                    EpisodeDetailCell(title: "Air date", description: episode.airDate)
                    EpisodeDetailCell(title: "Episode", description: episode.episode)
                }

                Section("Characters") {
                    List {
                        ForEach(viewModel.characters) { character in
                            NavigationLink {
                                CharacterDetailView(character: character)
                            } label: {
                                CharacterView(character: character)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Episode")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await viewModel.getRelatedCharacters(for: episode)
        }
    }
}

#Preview {
    EpisodeDetailView(episode: RMEpisode.testEpisode)
}

struct EpisodeDetailCell: View {
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
