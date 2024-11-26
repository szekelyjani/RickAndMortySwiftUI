//
//  CharacterListView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var vm = CharacterListViewViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(vm.characters) { character in
                        NavigationLink {
                            Text("\(character.name)")
                        } label: {
                            CharacterListCell(character: character)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 4)
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
                                    await vm.getNextCharacters()
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
        .onAppear {
            Task {
                await vm.getCharacters()
            }
        }
    }
    
}

#Preview {
    CharacterListView()
}
