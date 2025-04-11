//
//  EpisodeListView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 29..
//

import SwiftUI

struct EpisodeListView: View {
    @StateObject private var viewModel = EpisodeListViewViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.episodes) { episode in
                    NavigationLink {
                        EpisodeDetailView(episode: episode)
                    } label: {
                        EpisodeListCell(episode: episode)
                    }
                }
                switch viewModel.loadingState {
                case .loading:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .finished:
                    if viewModel.nextPageUrl != nil {
                        Color.gray.frame(height: 100)
                            .onAppear {
                                Task {
                                    await viewModel.getMoreEpisodes()
                                }
                            }
                    }
                default:
                    EmptyView()
                }
            }
            .navigationTitle("Episodes")
            .listStyle(.automatic)
        }
        .task {
            await viewModel.getEpisodes()
        }
    }
}

#Preview {
    EpisodeListView()
}
