//
//  EpisodeListView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 29..
//

import SwiftUI

struct EpisodeListView: View {
    @StateObject private var vm = EpisodeListViewViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.episodes) { episode in
                    NavigationLink {
                        EpisodeDetailView(episode: episode)
                    } label: {
                        EpisodeListCell(episode: episode)
                    }
                }
                switch vm.loadingState {
                case .loading:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .finished:
                    if vm.nextPageUrl != nil {
                        Color.gray.frame(height: 100)
                            .onAppear {
                                Task {
                                    await vm.getMoreEpisodes()
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
            await vm.getEpisodes()
        }
    }
}

#Preview {
    EpisodeListView()
}
