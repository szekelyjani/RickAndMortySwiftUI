//
//  CharacterListView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            CharacterListCell(character: character)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 4)
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
                                    await viewModel.getNextCharacters()
                                }
                            }
                    }
                default:
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Characters")
        }
        .task {
            await viewModel.getCharacters()
        }
    }
}

#Preview {
    CharacterListView()
}
