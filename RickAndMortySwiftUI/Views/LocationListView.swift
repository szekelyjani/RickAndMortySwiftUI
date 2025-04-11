//
//  LocationListView.swift
//  RickAndMortySwiftUI
//
//  Created by Szekely Janos on 2024. 11. 24..
//

import SwiftUI

struct LocationListView: View {
    @StateObject private var viewModel = LocationListViewViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.locations) { location in
                    NavigationLink {
                        LocationListCell(location: location)
                    } label: {
                        LocationListCell(location: location)
                    }
                }
                switch viewModel.loadingState {
                case .na:
                    if #available(iOS 17.0, *) {
                        ContentUnavailableView.search
                    } else {
                        EmptyView()
                    }
                case .loading:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .finished:
                    if viewModel.nextPageUrl != nil {
                        Color.gray.frame(height: 100)
                            .onAppear {
                                Task {
                                    await viewModel.getMoreLocations()
                                }
                            }
                    }
                default:
                    EmptyView()
                }
            }
            .navigationTitle("Locations")
            .listStyle(.automatic)
            .searchable(
                text: $viewModel.searchText,
                placement: .automatic,
                prompt: "Search Locations"
            )
        }
        .task {
            await viewModel.getAllLocations()
        }
        .onSubmit(of: .search) {
            Task {
                await viewModel.search()
            }
        }
    }
}

#Preview {
    LocationListView()
}
